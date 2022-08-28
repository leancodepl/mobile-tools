setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'

    DIR="$(cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd)"
    PATH="$DIR/../bin:$PATH"
}

package_name="maestro_cli"

@test "prints error when no package name" {
    run link-changelog
    assert_failure "error: missing package name"
}

@test "prints error when no tag" {
    run link-changelog "$package_name"
    assert_failure "error: missing tag"
}

@test "correctly processes  git tag" {
    run link-changelog "$package_name" v0.4.4
    assert_output "https://pub.dev/packages/$package_name/changelog#044"
}

@test "correctly processes git tag (1)" {
    run link-changelog "$package_name" v1
    assert_output "https://pub.dev/packages/$package_name/changelog#1"
}

@test "correctly processes git tag (2)" {
    run link-changelog "$package_name" v0.4.4
    assert_output "https://pub.dev/packages/$package_name/changelog#044"
}

@test "correctly processes git tag (3)" {
    run link-changelog "$package_name" v0.4.4+3
    assert_output "https://pub.dev/packages/$package_name/changelog#0443"
}

@test "correctly processes git tag (4)" {
    run link-changelog "$package_name" v1.12.15+32
    assert_output "https://pub.dev/packages/$package_name/changelog#1121532"
}
