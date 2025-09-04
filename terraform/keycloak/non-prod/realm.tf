resource "keycloak_realm" "non_prod" {
  lifecycle {
    prevent_destroy = true
  }

  realm        = "non-prod"
  display_name = "Non-Production"
  enabled      = true
  access_code_lifespan        = "900s"     // 15 min
  client_session_idle_timeout = "604800s"  // 7 days
  client_session_max_lifespan = "2592000s" // 30 days
  sso_session_idle_timeout    = "604800s"  // 7 days
  sso_session_max_lifespan    = "2592000s" // 30 days
  revoke_refresh_token        = true
  refresh_token_max_reuse     = 0
  registration_allowed           = true
  registration_email_as_username = true
}

# User Profile Attributes
resource "keycloak_realm_user_profile" "user_profile" {
  realm_id                   = keycloak_realm.non_prod.id
  unmanaged_attribute_policy = "ENABLED"

  group {
    name           = "user-metadata"
    display_header = "User Metadata"
  }

  attribute {
    name         = "username"
    display_name = "Username"
    group        = "user-metadata"
    multi_valued = false
    permissions {
      view = ["admin", "user"]
      edit = ["admin", "user"]
    }

    validator {
      name = "length"
      config = {
        min : 3
        max : 255
      }
    }
    validator {
      name   = "username-prohibited-characters"
      config = {}
    }
    validator {
      name   = "up-username-not-idn-homograph"
      config = {}
    }
  }

  attribute {
    name               = "email"
    display_name       = "Email"
    group              = "user-metadata"
    multi_valued       = false
    required_for_roles = ["user"]
    permissions {
      view = ["admin", "user"]
      edit = ["admin", "user"]
    }
    validator {
      name   = "email"
      config = {}
    }
    validator {
      name = "length"
      config = {
        max : 255
      }
    }
  }

  attribute {
    name               = "firstName"
    display_name       = "First Name"
    group              = "user-metadata"
    multi_valued       = false
    required_for_roles = ["user"]
    permissions {
      view = ["admin", "user"]
      edit = ["admin", "user"]
    }
    validator {
      name = "length"
      config = {
        max : 255
      }
    }
    validator {
      name   = "person-name-prohibited-characters"
      config = {}
    }
  }

  attribute {
    name               = "lastName"
    display_name       = "Last Name"
    group              = "user-metadata"
    multi_valued       = false
    required_for_roles = ["user"]
    permissions {
      view = ["admin", "user"]
      edit = ["admin", "user"]
    }
    validator {
      name = "length"
      config = {
        max : 255
      }
    }
    validator {
      name   = "person-name-prohibited-characters"
      config = {}
    }
  }

  attribute {
    name         = "userId"
    display_name = "userId"
    group        = "user-metadata"
    multi_valued = false
    permissions {
      view = ["admin"]
      edit = ["admin"]
    }
  }

  attribute {
    name         = "workspaceId"
    display_name = "workspaceId"
    group        = "user-metadata"
    multi_valued = false
    permissions {
      view = ["admin"]
      edit = ["admin"]
    }
  }
}