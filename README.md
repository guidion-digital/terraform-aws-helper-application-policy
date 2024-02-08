Part of the [Terrappy framework](https://github.com/guidion-digital/terrappy).

---

Small helper module containing correct permissions for predefined resource names. N.B. This module generates policies for the _application services themselves_ (e.g. the Lambdas), for workspace module permissions, see the [helper-workspace-policy module](https://github.com/guidion-digital/terraform-aws-helper-workspace-policy/).

# Rationale

Some of the permissions needed by applications are knowable. For example, if we know an application will use DynamoDB, we make the assumption here that its table is namespaced to `/${var.application_name}`, so we can create policies which grant access to that table. This creates consistent IAM policies for use with application modules, at the cost of relying on namespacing.

# Usage

See the [examples folder](./examples).

# Status

The following resources are supported:

- SQS
- DynamoDB
  
Some basic log (CloudWatch) permissins are also added. This enables log group writes (as well as creation) for services which use the `...log-group:/aws/[service]` format (for example `log-group:/aws/lambda/foobar`). Permissions are namespaced to `var.application_name`, as usual.

# Caveats and Gotchyas

Due to the way Terraform works out it's dependency tree, this module can not be used as part of the [Workspace](https://github.com/GuidionOps/terraform-tfe-infra-workspaces) to fill out an application's policy ARNs.
