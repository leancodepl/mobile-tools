#!/usr/bin/env bash
set -euo pipefail

# Set the variables below according to your needs
poeditorProjectId="355089"
translationsDir="./assets/l10n"
stringsFile="./lib/l10n/strings.dart"
mainLang="pl"
langs=("pl") # ("pl" "en" "de") etc

mkdir -p $translationsDir
mkdir -p $(dirname "$stringsFile")

for lang in "${langs[@]}"; do
    url=$(curl -sS -X POST https://api.poeditor.com/v2/projects/export \
        -d api_token="$POEDITOR_TOKEN" \
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
