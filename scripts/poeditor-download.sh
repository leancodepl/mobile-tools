#!/usr/bin/env bash
set -euo pipefail

poeditorProjectId="$POEDITOR_PROJECT_ID" # e.g "355089"
translationsDir="$POEDITOR_TRANSLATIONS_DIR" # e.g "./assets/l10n"
stringsFile="$POEDITOR_STRINGS_FILE" # e.g "./lib/l10n/strings.dart"
mainLang="$POEDITOR_MAIN_LANG" # e.g "pl"
langs="$POEDITOR_LANGS" # e.g "pl en de"

mkdir -p "$translationsDir"
mkdir -p "$(dirname "$stringsFile")"

set +u
token="$POEDITOR_TOKEN"
set -u

if [ -z "$token" ]; then
    token=$(cat "$HOME/.poeditor_token" 2> /dev/null || true)    
fi

if [ -z "$token" ]; then
    token=$(cat "${XDG_CONFIG_HOME:-$HOME/.config}/poeditor/token" 2> /dev/null || true)    
fi

if [ -z "$token" ]; then
    echo "POEditor token is not set"
    exit 1
fi

for lang in "${langs[@]}"; do
    url=$(curl -sS -X POST https://api.poeditor.com/v2/projects/export \
        -d api_token="$token" \
        -d id="$poeditorProjectId" \
        -d language="$lang" \
        -d type="key_value_json" \
    | jq '.result.url')

    curl -sS "${url//\"}" -o "$translationsDir/$lang.json"
done

# generate Strings class from JSON
echo "// ignore_for_file: constant_identifier_names" > $stringsFile
echo "" >> "$stringsFile"
echo "class Strings {" >> "$stringsFile"

# workaround for https://stackoverflow.com/a/47576101/7009800
if command -v ghead >& /dev/null
then
    head=ghead
else
    head=head
fi

jq 'keys' "$translationsDir/$mainLang.json" \
| $head -n -1 \
| tail -n +2 \
| awk -F'"' '{ name = $2; gsub(/\./, "_", name); printf "    static const %s = '"'"'%s'"'"';\n", name, $2 }' \
>> "$stringsFile"

echo "}" >> "$stringsFile"

dart format $stringsFile >& /dev/null
