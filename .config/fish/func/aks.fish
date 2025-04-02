function use-sd -a underlay
  set -l build_version (cat azureconfig.yaml | yq -r .azure.build_version)

  echo "Build version: $build_version"

  switch $underlay
    case svc
      echo "Switching to svc underlay cluster"
      set -gx KUBECONFIG (printf "%s/.kube/hcp%s-eastus2-svc-0-kubeconfig" $HOME $build_version)
    case cx
      echo "Switching to cx underlay cluster"
      set -gx KUBECONFIG (printf "%s/.kube/hcp%s-eastus2-cx-1-kubeconfig" $HOME $build_version)
    case '*'
      echo "Invalid underlay: $underlay"
      return 1
  end
end
