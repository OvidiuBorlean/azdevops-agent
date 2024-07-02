kubectl create secret generic azdevops \
  --from-literal=AZP_URL=https://dev.azure.com/organization/ \
  --from-literal=AZP_TOKEN=<token> \
  --from-literal=AZP_POOL=<name>
