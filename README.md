# XACML with Open Policy Agent

XACML is an OASIS standard for implementing policy as code. It was intended to be a widely adopted technology that would move authorization policy decisions out of application code and to a specialized Policy Decision Point (PDP). The terms often used in the OPA world like PDP, PIP (Policy Information Point), PEP (Policy Enforcement Point) all come from the XACML standard.

This repo shows how to integrate an XACML-based system with policy implemented in Rego and evaluated by OPA.

The input message is a XACML JSON profile formatted request, so is the response from OPA.

#### Usage

Run unit tests by `./test.sh`

Run OPA and send a request using `./run.sh` and `./request.sh`.

#### References

[XACML JSON Profile](http://docs.oasis-open.org/xacml/xacml-json-http/v1.0/xacml-json-http-v1.0.html)

[Original XACML policy](https://www.oasis-open.org/committees/download.php/2713/Brief_Introduction_to_XACML.html) that I converted to Rego
