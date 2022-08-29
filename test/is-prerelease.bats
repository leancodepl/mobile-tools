setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'

    DIR="$(cd "$( dirname "$BATS_TEST_FILENAME" )" 1>/dev/null 2>&1 && pwd)"
    PATH="$DIR/../bin:$PATH"
}

@test "prints error when no tag" {
    run is-prerelease
    assert_failure "error: missing tag"
}

@test "correctly processes version (1)" {
    run is-prerelease v1
    assert_output false
}

@test "correctly processes version (2)" {
    run is-prerelease v10
    assert_output false
}

@test "correctly processes version (3)" {
    run is-prerelease v1.0
    assert_output false
}

@test "correctly processes version (4)" {
    run is-prerelease v0.1
    assert_output true
}

@test "correctly processes version with prefix (1)" {
    run is-prerelease comms-v0.0.5 comms-
    assert_output true
}

@test "correctly processes version with prefix (2)" {
    run is-prerelease flutter_comms-v0.1 flutter_comms-
    assert_output true
}

@test "correctly processes version with prefix (3)" {
    run is-prerelease comms-v1.0.0 comms-
    assert_output false
}
