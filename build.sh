#!/bin/bash

set -e
source .env

tag=$(date "+%G%m%d")

docker pull lineageos4microg/docker-lineage-cicd:lineage-20

docker run \
    --env-file .env \
    -v "$PWD/srv/src:/srv/src" \
    -v "$PWD/srv/zips:/srv/zips" \
    -v "$PWD/srv/logs:/srv/logs" \
    -v "$PWD/srv/ccache:/srv/ccache" \
    -v "$PWD/srv/keys:/srv/keys" \
    -v "$PWD/srv/local_manifests:/srv/local_manifests" \
    lineageos4microg/docker-lineage-cicd

# create release
files="$PWD/srv/zips/$device/$branch-$tag-UNOFFICIAL-$device*"
sha256=$(cat "$PWD/srv/zips/$device/$branch-$tag-UNOFFICIAL-$device.zip.sha256sum" | grep -oP "^([a-f0-9]+)")

gh release create \
    --title "$branch-$tag-UNOFFICIAL-$device" \
    --notes "sha256: \`$sha256\`" \
    "$tag" \
    $files

# upload artifacts
for file in $files;
do
    rclone copy "$file" ota:/ --progress
done
