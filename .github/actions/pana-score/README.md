# pana-score action

Self-contained composite action that:

- sets up stable Dart (pub.dev-compatible scoring runtime),
- installs and runs `pana --json`,
- exposes `score` and `state` outputs,
- writes Markdown details to `$GITHUB_STEP_SUMMARY`,
- reports a `pana` commit status on the head SHA (fork-safe for pull requests),
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

## Required workflow permissions

```yaml
permissions:
  contents: read
  statuses: write
```
