package rules

default permit = false

current_time := time.now_ns()

permit {
  input.Request.Action.Attribute[a].AttributeId == "ServerAction"
  input.Request.Action.Attribute[a].Value == "login"
  current_time >= time_today("09:00:00Z")
  current_time <= time_today("17:00:00Z")
}

Response["Decision"] = "Permit" {
  permit
}

Response["Decision"] = "Deny" {
  not permit
}

Response["Status"] = status {
  status := {
        "StatusCode": {
            "Value": "urn:oasis:names:tc:xacml:1.0:status:ok",
            "StatusCode": {
                "Value": "urn:oasis:names:tc:xacml:1.0:status:ok"
            }
        }
    }
}

time_today(t) = time_ns {
  time_ns := time.parse_rfc3339_ns(sprintf("%02d-%02d-%02dT%v", array.concat(time.date(current_time), [t])))
}