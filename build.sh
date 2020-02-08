# uses forked docker image for android 10 support https://github.com/leophys/docker-lineage-cicd
# supply manifest.xml from this repo
# and before.sh from https://github.com/davinci-dev/manifest/blob/lineage-17.1/updates.sh

docker run \
    -e "BRANCH_NAME=lineage-17.1" \
    -e "DEVICE_LIST=davinci" \
    -e "SIGN_BUILDS=false" \
    -e "INCLUDE_PROPRIETARY=false" \
    -e "SIGNATURE_SPOOFING=restricted" \
    -e "CUSTOM_PACKAGES=GmsCore GsfProxy FakeStore MozillaNlpBackend NominatimNlpBackend com.google.android.maps.jar FDroid FDroidPrivilegedExtension " \
    -v "/home/hi/android/lineage:/srv/src" \
    -v "/home/hi/android/zips:/srv/zips" \
    -v "/home/hi/android/logs:/srv/logs" \
    -v "/home/hi/android/cache:/srv/ccache" \
    -v "/home/hi/android/keys:/srv/keys" \
    -v "/home/hi/android/manifests:/srv/local_manifests" \
    -v "/home/hi/android/scripts:/srv/userscripts" \
   lineage
