# Non-Prod Test Users
resource "keycloak_group" "test_users" {
  realm_id = keycloak_realm.non_prod.id
  name     = "test-users"
}

resource "keycloak_user" "john" {
  lifecycle {
    ignore_changes  = [attributes]
    prevent_destroy = true
  }

  realm_id       = keycloak_realm.non_prod.id
  username       = "john@np.com"
  email          = "john@np.com"
  enabled        = true
  email_verified = true
  first_name     = "John"
  last_name      = "Doe"
  initial_password {
    value = var.test_user_password
  }
}

resource "keycloak_user_groups" "john_groups" {
  realm_id = keycloak_realm.non_prod.id
  user_id  = keycloak_user.john.id

  group_ids = [
    keycloak_group.test_users.id
  ]
}

resource "keycloak_user" "mary" {
  lifecycle {
    ignore_changes  = [attributes]
    prevent_destroy = true
  }

  realm_id       = keycloak_realm.non_prod.id
  username       = "mary@np.com"
  email          = "mary@np.com"
  enabled        = true
  email_verified = true
  first_name     = "Mary"
  last_name      = "Doe"
  initial_password {
    value = var.test_user_password
  }
}

resource "keycloak_user_groups" "mary_groups" {
  realm_id = keycloak_realm.non_prod.id
  user_id  = keycloak_user.mary.id

  group_ids = [
    keycloak_group.test_users.id
  ]
}