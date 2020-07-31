#!/bin/bash

# tag name: YYYYMMDD
tag=$(date +%Y%m%d)

# file needs to be passed as first parameter
file="$1"

# filename without .zip
base=$(basename -s .zip "$file")

# checksums
sha256=($(sha256sum "$file"))
md5=($(md5sum "$file"))

# release message: first line is title
message="$base"$'\n\n'"sha256: \`$sha256\`"$'\n'"md5: \`$md5\`"

# create draft release
hub release create -d -a "$file" -m "$message" "$tag"
