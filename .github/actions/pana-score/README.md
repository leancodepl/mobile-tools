# pana-score action

Self-contained composite action that:

- sets up a pub.dev-compatible scoring runtime: stable Dart, or stable
  Flutter for packages that declare `sdk: flutter` in `pubspec.yaml` (pana
  shells out to `flutter pub` for those, and fails hard without it),
- installs the `webp` command-line tools (`cwebp`, `dwebp`, `gif2webp`,
  `webpmux`, `webpinfo`) pana needs to score example/README screenshots —
  see [dart-lang/pana#1553](https://github.com/dart-lang/pana/issues/1553)
  (Linux runners only; other runners get a warning instead),
- installs and runs `pana --json`,
- exposes `score` and `state` outputs,
- writes Markdown details to `$GITHUB_STEP_SUMMARY`,
- reports a `pana (<package-name>)` commit status on the head SHA (fork-safe for
  pull requests), so scoring several packages in one workflow gives each its own
  status entry instead of overwriting a shared one,
- fails when no valid score is present.

## Usage

```yaml
- name: Score with pana
  id: pana
  continue-on-error: true
  uses: leancodepl/mobile-tools/.github/actions/pana-score@master
  with:
    path: .
```

`continue-on-error: true` keeps `pana` informational in the workflow while still
publishing its status and summary.

## Inputs

- `path` (default: `.`): package root directory.
- `report-status` (default: `true`): whether to publish commit status.

## Outputs

- `score`: e.g. `98/100`.
- `state`: one of `success`, `failure`, `error`.
- `package-name`: resolved from the package's `pubspec.yaml` (falling back to
  its directory name, then `unknown`), used to namespace the commit status
  context. Always set, even if the score step itself fails.

## Required workflow permissions

```yaml
permissions:
  contents: read
  statuses: write
```
