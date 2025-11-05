function use-sd --argument-names underlay
    set --local build_version (cat azureconfig.yaml | yq -r .azure.build_version)

    echo "Build version: $build_version"

    switch $underlay
        case svc
            echo "Switching to svc underlay cluster"
            set --global --export KUBECONFIG (printf "%s/.kube/hcp%s-eastus2-svc-0-kubeconfig" $HOME $build_version)
        case cx
            echo "Switching to cx underlay cluster"
            set --global --export KUBECONFIG (printf "%s/.kube/hcp%s-eastus2-cx-1-kubeconfig" $HOME $build_version)
        case '*'
            echo "Invalid underlay: $underlay"
            return 1
    end
end

function create-cluster --argument-names name
    set --local managed_cluster_subscription (cat azureconfig.yaml | yq -r .azure.managed_cluster_subscription)

    ./bin/aksdev cluster create $name --wait
    ./bin/aksdev cluster kubeconfig $name --managedclustersubscription $managed_cluster_subscription >~/.kube/$name.kubeconfig
    set --global --export KUBECONFIG ~/.kube/$name.kubeconfig
    set --local resource_id (./bin/aksdev cluster get $name | jq -r .id)
    echo "Resource ID: $resource_id"
    set --local subscription_id (echo $resource_id | cut -d '/' -f 3)
    set --local resource_group (echo $resource_id | cut -d '/' -f 5)
    echo "Subscription ID: $subscription_id"
    echo "Resource Group: $resource_group"
end
