function aks-dump-api-proxy-config
    set --local output_file "envoy-ccp.yaml"

    echo "Dumping API proxy config using KUBECONFIG=$KUBECONFIG to $output_file"

    kubectl get configmap kube-apiproxy-config -o jsonpath='{.data.envoy-ccp\.yaml}' >$output_file
end
