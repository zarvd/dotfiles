from abc import ABC, abstractmethod
from argparse import ArgumentParser
from enum import Enum
import platform
import shutil
import subprocess

from ui import UI

versions = {"go": "1.23.1"}


def run(cmd: str) -> str:
    rv = subprocess.run(cmd, check=True, text=True, stdout=subprocess.PIPE, shell=True)
    return rv.stdout.strip()


class Platform(ABC):
    def install_utilities(self):
        cargo_pkgs = [
            "bat",
            "fd-find",
            "git-delta",
            "just",
            "lsd",
            "ripgrep",
            "tealdeer",
            "tokei",
        ]
        for pkg in cargo_pkgs:
            UI.step(f"Installing {pkg}")
            run(f"cargo install {pkg} --locked --force")

    @abstractmethod
    def install_docker(self):
        pass

    @abstractmethod
    def install_fish(self):
        pass

    @UI.section("Installing Rust")
    def install_rust(self):
        if shutil.which("rustup"):
            if UI.confirm("Rust is already installed, do you want to reinstall?"):
                return
        run(
            "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
        )
        run("mkdir -p ${HOME}/.cargo")
        run("ln -s $(realpath .cargo/config.toml) ${HOME}/.cargo/config.toml")

    @abstractmethod
    def install_golang(self):
        pass

    @staticmethod
    def instance():
        system = platform.system()
        if system == "Linux":
            return Ubuntu()
        elif system == "Darwin":
            return MacOS()
        else:
            raise NotImplementedError(f"Unsupported platform: {system}")


class Ubuntu(Platform):
    os_release = {}
    arch = ""

    def __init__(self) -> None:
        with open("/etc/os-release") as f:
            for line in f:
                key, value = line.strip().split("=")
                self.os_release[key] = value
        self.arch = run("dpkg --print-architecture")

    @UI.section("Installing utilities")
    def install_utilities(self):
        run("sudo apt update")
        run("sudo apt install -y build-essential make jq")
        super().install_utilities()

    @UI.section("Installing Docker")
    def install_docker(self):
        if shutil.which("docker"):
            if UI.confirm("Docker is already installed, do you want to reinstall?"):
                return

        UI.step("Install dependencies")
        run("sudo apt-get update")
        run("sudo apt-get install -y ca-certificates curl")
        run("sudo install -m 0755 -d /etc/apt/keyrings")
        run(
            "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc"
        )
        run("sudo chmod a+r /etc/apt/keyrings/docker.asc")

        UI.step("Add Docker repository")
        with open("/etc/apt/sources.list.d/docker.list", "w") as f:
            arch = self.arch
            codename = self.os_release["VERSION_CODENAME"]
            f.write(
                f"deb [arch={arch}] https://download.docker.com/linux/ubuntu {codename} stable"
            )
        run("sudo apt-get update")
        UI.step("Install Docker")
        run(
            "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
        )
        run("sudo usermod -aG docker ${USER}")

    @UI.section("Installing Fish")
    def install_fish(self):
        if shutil.which("fish"):
            if UI.confirm("Fish is already installed, do you want to reinstall?"):
                return

        UI.step("Install fish")
        run("sudo apt-add-repository -y ppa:fish-shell/release-3")
        run("sudo apt update")
        run("sudo apt install -y fish")

        UI.step("Install fisher")
        run(
            "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source"
        )
        run("fisher install jorgebucaran/fisher")
        run("fisher install jethrokuan/z")

        UI.step("Setup fish config")
        run("mkdir -p ${HOME}/.config/fish")
        run(
            "ln -sf $(realpath .config/fish/config.fish) ~/.config/fish/config.fish"
        )
        run(
            "ln -sf $(realpath .config/fish/fish_plugins) ~/.config/fish/fish_plugins"
        )

        UI.step("Change shell to fish")
        run(
            "sudo sed -i 's/auth\s\+required\s\+pam_shells.so/auth sufficient pam_shells.so/g' /etc/pam.d/chsh"
        )
        run("chsh -s $(which fish)")

    @UI.section("Installing Go")
    def install_golang(self):
        if shutil.which("go"):
            if UI.confirm("Go is already installed, do you want to reinstall?"):
                return

        UI.step(f"Downloading Go {versions['go']}")

        url = "https://go.dev/dl/go${}.linux-amd64.tar.gz".format(versions["go"])
        path = "${HOME}/downloads/go.tar.gz"

        run("mkdir -p ${HOME}/downloads")
        run(f"curl -o ${path} ${url}")

        run("sudo rm -rf /usr/local/go")
        run(f"sudo tar -C /usr/local -xzf ${path}")


class MacOS(Platform):
    @UI.section("Installing utilities")
    def install_utilities(self):
        super().install_utilities()

    @UI.section("Installing Docker")
    def install_docker(self):
        if shutil.which("docker"):
            if UI.confirm("Docker is already installed, do you want to reinstall?"):
                return

    @UI.section("Installing Fish")
    def install_fish(self):
        UI.step("Install brew")
        UI.step("Install fisher")
        UI.step("Setup fish config")

    @UI.section("Installing Go")
    def install_golang(self):
        if shutil.which("go"):
            if UI.confirm("Go is already installed, do you want to reinstall?"):
                return


class Action(Enum):
    INSTALL = "install"
    HELP = "help"

    def do(self):
        if self == Action.INSTALL:
            UI.header("Installing development environment")
            p = Platform.instance()
            p.install_fish()
            p.install_docker()
            p.install_golang()
            p.install_rust()
            p.install_utilities()
        elif self == Action.HELP:
            UI.header("Help")

    def __str__(self) -> str:
        return self.value


def main():
    parser = ArgumentParser(
        prog="machine",
        description="Setup your development environment",
    )
    parser.add_argument("action", type=Action, choices=list(Action))
    args = parser.parse_args()
    args.action.do()


if __name__ == "__main__":
    main()
