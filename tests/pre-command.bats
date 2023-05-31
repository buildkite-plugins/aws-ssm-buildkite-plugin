#!/usr/bin/env bats

load "${BATS_PLUGIN_PATH}/load.bash"

# Uncomment to enable stub debugging
# export AWS_STUB_DEBUG=/dev/tty

@test "Exports parameters from SSM Store" {
    export BUILDKITE_PLUGIN_AWS_SSM_PARAMETERS_PARAMETER_ONE=/my/parameter/one
    export BUILDKITE_PLUGIN_AWS_SSM_PARAMETERS_PARAMETER_TWO=/my/parameter/two

    # Deliberately output the parameters in a different order to ensure they are mapped correctly
    stub aws "ssm get-parameters --with-decryption --query Parameters[].[Name,Value] --output text --names /my/parameter/one /my/parameter/two : echo -e \"/my/parameter/two\tsecrettwo\n/my/parameter/one\tsecretone\""

    run "$PWD/hooks/pre-command"

    assert_output --partial "Exported PARAMETER_TWO as value of parameter /my/parameter/two"
    assert_output --partial "Exported PARAMETER_ONE as value of parameter /my/parameter/one"

    assert_success

    unstub aws
}
