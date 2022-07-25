package test

import data.rules.Response
import data.rules.current_time

test_permit_0930_time {
  response := Response with input as {
    "Request": {
      "Action": {
        "Attribute": [
          {
            "AttributeId": "ServerAction",
            "Value": "login"
          }
        ]
      }
    }
  } with current_time as time.parse_rfc3339_ns("2022-07-20T09:30:00.00Z")

  # permitted because time is between 9:00 and 17:00 and it's a weekday
  response.Decision == "Permit"
}

test_deny_after_1700_time {
  response := Response with input as {
    "Request": {
      "Action": {
        "Attribute": [
          {
            "AttributeId": "ServerAction",
            "Value": "login"
          }
        ]
      }
    }
  } with current_time as time.parse_rfc3339_ns("2022-07-20T17:30:00.00Z")

  # denied because time is after 17:00
  response.Decision == "Deny"
}

test_weekend_login_denied {
  response := Response with input as {
    "Request": {
      "Action": {
        "Attribute": [
          {
            "AttributeId": "ServerAction",
            "Value": "login"
          }
        ]
      }
    }
  } with current_time as time.parse_rfc3339_ns("2022-07-23T12:30:00.00Z")

  # denied because it's a weekend
  response.Decision == "Deny"
}

test_weekend_logout_permit {
  response := Response with input as {
    "Request": {
      "Action": {
        "Attribute": [
          {
            "AttributeId": "ServerAction",
            "Value": "logout"
          }
        ]
      }
    }
  } with current_time as time.parse_rfc3339_ns("2022-07-23T12:30:00.00Z")

  # logout is permitted even on the weekend
  response.Decision == "Permit"
}