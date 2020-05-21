# using fork until official container gets lineage-17.1 support
docker build https://github.com/SolidHal/docker-lineage-cicd.git#lineageos-17.1 --tag lineage

# download latest updates.sh from manifest repo
mkdir -p scripts
curl https://raw.githubusercontent.com/sm6150-dev/manifest/lineage-17.1/updates.sh > scripts/pre-build.sh

# start the build
docker run \
    -e "BRANCH_NAME=lineage-17.1" \
    -e "DEVICE_LIST=davinci" \
    -e "SIGN_BUILDS=true" \
    -e "INCLUDE_PROPRIETARY=false" \
    -e "SIGNATURE_SPOOFING=restricted" \
    -e "CUSTOM_PACKAGES=GmsCore GsfProxy FakeStore MozillaNlpBackend NominatimNlpBackend com.google.android.maps.jar FDroid FDroidPrivilegedExtension " \
    -v "$PWD/lineage:/srv/src" \
    -v "$PWD/zips:/srv/zips" \
    -v "$PWD/logs:/srv/logs" \
    -v "$PWD/cache:/srv/ccache" \
    -v "$PWD/keys:/srv/keys" \
    -v "$PWD/manifests:/srv/local_manifests" \
    -v "$PWD/scripts:/srv/userscripts" \
   lineage
