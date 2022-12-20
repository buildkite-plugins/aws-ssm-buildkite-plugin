# AWS SSM Buildkite Plugin

🔑 Injects AWS SSM Parameter Store parameters as environment variables into your build step.

Based on previous work by [zacharymctague](https://github.com/zacharymctague/aws-ssm-buildkite-plugin), [Linktree](https://github.com/blstrco/aws-sm-buildkite-plugin), and [Seek](https://github.com/seek-oss/aws-sm-buildkite-plugin).

The plugin requires the `ssm:GetParameters` IAM permission for the parameters you specify.

## Example

Add the following to your `pipeline.yml`:

```yml
steps:
  - command: echo "Param One equals \$PARAMETER_ONE"
    plugins:
      - aws-ssm#v1.0.0:
          parameters:
            PARAMETER_ONE: /my/parameter
            PARAMETER_TWO: /my/other/parameter
```

## Configuration

### `parameters` (Required, object)

- Specify a dictionary of `key: value` pairs to inject as environment variables, where the key is the name of the
  environment variable to be set, and the value is the AWS SSM parameter path.

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```

## Contributing

1. Fork the repo
2. Make the changes
3. Run the tests
4. Commit and push your changes
5. Send a pull request
