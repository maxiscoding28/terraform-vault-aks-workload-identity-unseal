terraform output -json > terraform_output.json

az aks get-credentials \
    --resource-group "$(jq -r '.inputs_for_az_aks_get_credentials.value.resource_group_name' terraform_output.json)" \
    --name "$(jq -r '.inputs_for_az_aks_get_credentials.value.cluster_name' terraform_output.json)"
