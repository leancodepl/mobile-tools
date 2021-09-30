#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# adapted from: https://leancode.atlassian.net/wiki/spaces/LEAN/pages/1293844508/Android+signing+policy

app_name="$1"
owner="$2"

echo "Creating keystore for app $app_name with owner $owner"

gen_key() {
    app_name="$1"
    owner="$2"
    flavor="$3"
    
    echo "Generating $flavor key for $app_name:"
    
    keytool -genkey \
    -keystore "${app_name}_$flavor.jks" \
    -keyalg RSA \
    -keysize 2048 \
    -validity 9125 `# 25 years (25 * 365 = 9125 days)` \
    -alias "${app_name}_$flavor" \
    -dname "O=$owner" \
    -noprompt
}


gen_key "$app_name" "LeanCode" "tst"
gen_key "$app_name" "$owner" "prod"
gen_key "$app_name" "$owner" "prod_upload"
