# Non-Prod Test Users
resource "keycloak_user" "john" {
  realm_id       = keycloak_realm.non_prod.id
  username       = "john@np.com"
  email          = "john@np.com"
  enabled        = true
  email_verified = true
  first_name     = "John"
  last_name      = "Doe"
  initial_password {
    value = "password123"
  }
}

resource "keycloak_user" "mary" {
  realm_id       = keycloak_realm.non_prod.id
  username       = "mary@np.com"
  email          = "mary@np.com"
  enabled        = true
  email_verified = true
  first_name     = "Mary"
  last_name      = "Smith"
  initial_password {
    value = "password123"
  }
}