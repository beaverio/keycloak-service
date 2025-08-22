## Steps to create a Keycloak instance

```bash
fly postgres create \
  --name <NAME_OF_DB> \   
  --region atl \
  --initial-cluster-size 1 \
  --volume-size 1 # Start small, increase as needed
```

```bash
fly apps create <NAME_OF_APP>
```

```bash
fly secrets set \
  KC_DB='postgres' \
  KC_DB_URL='jdbc:postgresql://<DB_NAME>.internal:5432/postgres' \
  KC_DB_USERNAME='postgres' \
  KC_DB_PASSWORD='<DB_PASSWORD>' \
  KC_HOSTNAME='<DB_NAME>.fly.dev' \
  KC_HTTP_ENABLED='true' \
  KC_HTTP_PORT='8080' \
  KC_PROXY_HEADERS='xforwarded' \
  KC_BOOTSTRAP_ADMIN_USERNAME='admin' \
  KC_BOOTSTRAP_ADMIN_PASSWORD='changeme' \
  --app <DB_NAME>
```

```bash
fly deploy --config deployments/<ENV>.toml
```