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

function reset-sd-ingress
  use-sd svc

  k get svc -n rp-ingress
  k delete svc rp-ingress-svc rp-ingress-svc-b -n rp-ingress
  sleep 10s
  k delete pod --all -n deployer
  k get svc -n rp-ingress --watch
end
