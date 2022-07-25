package rules
import future.keywords.in

current_time := time.now_ns()

permit {
  input.Request.Action.Attribute[a].AttributeId == "ServerAction"
  input.Request.Action.Attribute[a].Value == "login"
  current_time >= time_today("09:00:00Z")
  current_time <= time_today("17:00:00Z")
}

permit {
  input.Request.Action.Attribute[a].AttributeId == "ServerAction"
  input.Request.Action.Attribute[a].Value == "logout"
}

deny {
  day := time.weekday(current_time)
  day in {"Saturday", "Sunday"}
  input.Request.Action.Attribute[a].Value != "logout"
}

default permit = false
default deny = false

Response["Decision"] = "Permit" {
  permit
  not deny
}

Response["Decision"] = "Deny" {
  not permit
}

Response["Decision"] = "Deny" {
  deny
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