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
read -N 1 -p "Create release? (y/n)" answer
if ["$answer" == "y"]; then
    gh release create "$tag"
fi

# upload artifacts
read -N 1 -p "Upload artifacts? (y/n)" answer
if ["$answer" != "y"]; then exit 0; fi

files="srv/zips/$device/$branch-$tag-UNOFFICIAL-$device*"
for file in $files;
do
    rclone copy "$file" ota:/ --progress
    gh release upload "$tag" "$file"
done