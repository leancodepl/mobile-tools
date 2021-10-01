# mobile-tools

All useful scripts gathered in one place.

### generate-keystores

Generates `tst`, `prod` and `prod_upload` keystore (`.jks`) files.

### poeditor-download

Downloads translations from POEditor and converts them to Dart code.

Requires a `poeditor_config` file in the root of your mobile project.

```sh
#!/usr/bin/env bash

export POEDITOR_PROJECT_ID=355089
export POEDITOR_TRANSLATIONS_DIR=./assets/l10n
export POEDITOR_STRINGS_FILE=./lib/l10n/strings.dart
export POEDITOR_MAIN_LANG=pl
export POEDITOR_LANGS=pl

```

You also must provide a POEditor token to the script. You have 3 options:

- `$ export POEDITOR_TOKEN="token here"`
- `$ echo "token here" > "$HOME/.config/poeditor/token"` (XDG_CONFIG_HOME)
- `$ echo "token here" > "$HOME/.poeditor_token"`
