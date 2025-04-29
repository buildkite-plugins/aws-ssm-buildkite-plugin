# AWS SSM Buildkite Plugin [![Build status](https://badge.buildkite.com/981686fe9b2a1f79407923a1f1412281967b800d433cb82a1c.svg?branch=main)](https://buildkite.com/buildkite/plugins-aws-ssm)

🔑 Injects AWS SSM Parameter Store parameters as environment variables into your build step.

Based on previous work by [zacharymctague](https://github.com/zacharymctague/aws-ssm-buildkite-plugin), [Linktree](https://github.com/blstrco/aws-sm-buildkite-plugin), and [Seek](https://github.com/seek-oss/aws-sm-buildkite-plugin).

The plugin requires the `ssm:GetParameters` IAM permission for the parameters you specify. If the values are SecureStrings, it will also require `kms:Decrypt` on the corresponding KMS key.

## Example

Add the following to your `pipeline.yml`:

```yml
steps:
  - command: echo "Param One equals \$PARAMETER_ONE"
    plugins:
      - aws-ssm#v1.1.0:
          parameters:
            PARAMETER_ONE: /my/parameter
            PARAMETER_TWO: /my/other/parameter
```

## Configuration

### `parameters` (Required, object)

- Specify a dictionary of `key: value` pairs to inject as environment variables, where the key is the name of the
  environment variable to be set, and the value is the AWS SSM parameter path.

## Limitations

Parameter Store can hold multi-line values, but only the first line will be
stored in the target ENV variable. If multi-line values are required, the
recommended approach is to store the value base64 encoded and decode it in your
scripts:

```yml
steps:
  - command: ./decode-param"
    plugins:
      - aws-ssm#v1.1.0:
          parameters:
            PARAMETER_BASE64: /my/parameter
```

To decode:

```bash
$ cat ./decode-param
#!/bin/sh

PARAMETER="$(echo $PARAMETER_BASE64 | base64 -d)"
echo "Param equals: ${PARAMETER}"
```

## Developing

To run testing, shellchecks and plugin linting use use `bk run` with the [Buildkite CLI](https://github.com/buildkite/cli).

```bash
bk run
```

Or if you want to run just the tests, you can use the docker [Plugin Tester](https://github.com/buildkite-plugins/buildkite-plugin-tester):

```bash
docker run --rm -ti -v "${PWD}":/plugin buildkite/plugin-tester:latest
```

## Contributing

1. Fork the repo
2. Make the changes
3. Run the tests
4. Commit and push your changes
5. Send a pull request
