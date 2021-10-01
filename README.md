# mobile-tools

All useful scripts gathered in one place.

### `poeditor_download`

Scaffold source script, to be placed in the root of your mobile project.

`poeditor_config`

```sh
export POEDITOR_PROJECT_ID=123456
export POEDITOR_TRANSLATIONS_DIR=./assets/l10n
export POEDITOR_STRINGS_FILE=./lib/l10n/strings.dart
export POEDITOR_MAIN_LANG=pl
export POEDITOR_LANGS="pl en de"
```

You also must provide a POEditor token to the script. You have 3 options:

- `$ export POEDITOR_TOKEN="token here"`
- `$ echo "token here" > "$HOME/.config/poeditor/token"` (XDG_CONFIG_HOME)
- `$ echo "token here" > "$HOME/.poeditor_token"`
