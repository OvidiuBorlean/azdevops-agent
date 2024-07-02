#TOKEN=$(az acr login --name xyz.azurecr.io --expose-token --output tsv --query accessToken)
#docker login xyz.azurecr.io --username 00000000-0000-0000-0000-000000000000 --password-stdin <<< $TOKEN
docker build -t azdevops .
docker tag azdevops xyz.azurecr.io/azdevops
docker push xyz.azurecr.io/azdevops
