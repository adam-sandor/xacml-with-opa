package test

import data.rules.Response
import data.rules.current_time

test_time_is_right {
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

  response.Decision == "Permit"
}

test_denied_time {
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

  response.Decision == "Deny"
}