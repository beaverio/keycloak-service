data "keycloak_openid_client" "realm_mgmt_np" {
  realm_id  = keycloak_realm.local.id
  client_id = "realm-management"
}

# The composite role that grants full realm admin:
data "keycloak_role" "realm_admin_np" {
  realm_id  = keycloak_realm.local.id
  client_id = data.keycloak_openid_client.realm_mgmt_np.id
  name      = "realm-admin"
}