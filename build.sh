#!/bin/bash

set -e

device="davinci"
branch="lineage-19.1"
tag=$(date "+%G%m%d")

# build
docker pull lineageos4microg/docker-lineage-cicd
docker run \
    -e "BRANCH_NAME=$branch" \
    -e "DEVICE_LIST=$device" \
    -e "SIGN_BUILDS=true" \
    -e "SIGNATURE_SPOOFING=restricted" \
    -e "INCLUDE_PROPRIETARY=false" \
    -e "CUSTOM_PACKAGES=GmsCore GsfProxy FakeStore IchnaeaNlpBackend NominatimGeocoderBackend FDroid FDroidPrivilegedExtension" \
    -e "OTA_URL=https://ota.krmax44.de/api" \
    -e "PARALLEL_JOBS=6" \
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