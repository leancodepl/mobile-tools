# mobile-tools

All useful scripts gathered in one place.

### Install

`$ brew tap leancodepl/tools`

`$ brew install mobile-tools`

## Programs

To learn more about programs, see their source code. They should have an
extensive comment at the top of the file.

### generate-keystore

Generates `tst`, `prod_upload`, and `prod` keystore (`.jks`) files.

**App signing by Google Play**

Upload created `prod` key instead of letting Google Play create one.

Uploading keystore to Google is available when uploading the first build.

**IMPORTANT!**

Adding `prod_upload` key needs to be done in the same transaction!

![](img/generate-keystores_1.png) ![](img/generate-keystores_2.png)

### poeditor-download

> This script is deprecated. Use [poe2arb][poe2arb] instead.

Downloads translations from POEditor and converts them to Dart code.

Requires an executable `poeditor_config` file in the root of your mobile
project.

```sh
#!/usr/bin/env bash

export POEDITOR_PROJECT_ID=355089
export POEDITOR_TRANSLATIONS_DIR=./assets/l10n
export POEDITOR_STRINGS_FILE=./lib/l10n/strings.dart
export POEDITOR_STRINGS_NAMESPACE=Strings
export POEDITOR_MAIN_LANG=pl
export POEDITOR_LANGS=pl
export POEDITOR_EXTRA_DIRECTIVES="export '../my_extensions.dart';"
```

You also must provide a POEditor token to the script. You have 3 options:

- `$ export POEDITOR_TOKEN="token here"`
- `$ echo "token here" > "$HOME/.config/poeditor/token"` (XDG_CONFIG_HOME)
- `$ echo "token here" > "$HOME/.poeditor_token"`

[poe2arb]: https://github.com/leancodepl/poe2arb
