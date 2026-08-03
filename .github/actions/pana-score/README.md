# pana-score action

Self-contained composite action that:

- sets up stable Dart (pub.dev-compatible scoring runtime),
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

- `score`: e.g. `package-name: 98/100`.
- `state`: one of `success`, `failure`, `error`.
- `package-name`: resolved from the package's `pubspec.yaml` (or its directory
  name), used to namespace the commit status context.

## Required workflow permissions

```yaml
permissions:
  contents: read
  statuses: write
```
