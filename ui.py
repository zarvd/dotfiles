from datetime import datetime
from enum import Enum
from functools import wraps
import time


class Color(Enum):
    # Foreground colors
    FG_BLACK = "\033[30m"
    FG_RED = "\033[31m"
    FG_GREEN = "\033[32m"
    FG_YELLOW = "\033[33m"
    FG_BLUE = "\033[34m"
    FG_MAGENTA = "\033[35m"
    FG_CYAN = "\033[36m"
    FG_WHITE = "\033[37m"

    # Background colors
    BG_BLACK = "\033[40m"
    BG_RED = "\033[41m"
    BG_GREEN = "\033[42m"
    BG_YELLOW = "\033[43m"
    BG_BLUE = "\033[44m"
    BG_MAGENTA = "\033[45m"
    BG_CYAN = "\033[46m"
    BG_WHITE = "\033[47m"

    # Formatting
    BOLD = "\033[1m"
    DIM = "\033[2m"
    UNDERLINE = "\033[4m"
    BLINK = "\033[5m"

    END = "\033[0m"

    @staticmethod
    def fg_yellow(text: str) -> str:
        return f"{Color.FG_YELLOW.value}{text}{Color.END.value}"

    @staticmethod
    def fg_cyan(text: str) -> str:
        return f"{Color.FG_CYAN.value}{text}{Color.END.value}"

    @staticmethod
    def fg_blue(text: str) -> str:
        return f"{Color.FG_BLUE.value}{text}{Color.END.value}"

    @staticmethod
    def fg_green(text: str) -> str:
        return f"{Color.FG_GREEN.value}{text}{Color.END.value}"

    @staticmethod
    def fg_red(text: str) -> str:
        return f"{Color.FG_RED.value}{text}{Color.END.value}"

    @staticmethod
    def bold(text: str) -> str:
        return f"{Color.BOLD.value}{text}{Color.END.value}"

    @staticmethod
    def dim(text: str) -> str:
        return f"{Color.DIM.value}{text}{Color.END.value}"

    @staticmethod
    def underline(text: str) -> str:
        return f"{Color.UNDERLINE.value}{text}{Color.END.value}"

    @staticmethod
    def blink(text: str) -> str:
        return f"{Color.BLINK.value}{text}{Color.END.value}"


class UI:
    width = 80

    @staticmethod
    def _center_text(text: str, border: str = " ", padding: int = 1) -> str:
        text = padding * " " + text + padding * " "
        return text.center(UI.width, border)

    @staticmethod
    def header(text: str):
        border = "="

        def p(text: str) -> str:
            return print(Color.bold(Color.fg_blue(text)))

        p(border * UI.width)
        p(UI._center_text(text, border=border))
        p(border * UI.width)

    @staticmethod
    def section(name: str, **kwargs):
        border = "-"

        now = datetime.now().strftime("%H:%M:%S")
        name = f"{name} [{now}]"

        def p(text: str) -> str:
            return print(Color.fg_green(text))

        def decorator(func):
            @wraps(func)
            def wrapper(*args, **kwargs):
                p(border * UI.width)
                p(UI._center_text(name, border=border))
                p(border * UI.width)
                t1 = time.perf_counter()
                rv = func(*args, **kwargs)
                elapsed = time.perf_counter() - t1
                print(Color.fg_cyan(f"Elapsed time: {elapsed:.3f}s"))
                return rv

            return wrapper

        return decorator

    @staticmethod
    def step(name: str, **kwargs):
        now = datetime.now().strftime("%H:%M:%S")

        text = f"{Color.fg_cyan(now)} STEP {Color.bold(name)}"
        print(text)

    @staticmethod
    def info(message: str):
        pass

    @staticmethod
    def warning(message: str):
        now = datetime.now().strftime("%H:%M:%S")
        text = f"{Color.fg_cyan(now)} {Color.fg_yellow('WARNING')} {message}"
        print(text)

    @staticmethod
    def error(message: str):
        pass
