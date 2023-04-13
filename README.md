# Lineage for microG builds for the Xiaomi Mi 9T/Redmi K20 (davinci)

[![Last release date badge](https://img.shields.io/github/release-date/krmax44/davinci-lineage-microg?label=last%20build)](https://github.com/krmax44/davinci-lineage-microg/releases/latest)
![LineageOS version 20](https://img.shields.io/badge/LineageOS-20.0-%23167c80)
![OTA updates available](https://img.shields.io/badge/OTA%20updates-yes-success)

Under [Releases](https://github.com/krmax44/davinci-lineage-microg/releases), you can find unofficial LineageOS builds that come with MicroG and F-Droid built-in. If you don't know what MicroG is, you probably want to use the default LineageOS builds.

## Installation

> **Warning**
> Proceed at your own risk. All files and instructions are provided as-is without any warranty.

1. Unlock the bootloader.
2. Download the ROM zip and recovery image from [the latest release](https://github.com/krmax44/davinci-lineage-microg/releases/latest).
3. Flash the recovery using `fastboot`. Using [TWRP recovery](https://twrp.me/xiaomi/xiaomimi9t.html) can work too, but is not recommended.
4. Boot to recovery and flash the ROM zip via `adb sidelaod`.

Once you unlocked the bootloader and installed the official [TWRP recovery](https://twrp.me/xiaomi/xiaomimi9t.html), you can boot to TWRP and flash the downloaded ZIP from the latest release.

OTA updates are available.

## Building yourself

As simple as running [./build.sh](./build.sh). The script uses the [LineageOS for MicroG Docker builder](https://github.com/lineageos4microg/docker-lineage-cicd).

## Sources

See [davinci.xml](./srv/local_manifests/davinci.xml). Big thanks to [ArianK16a](https://github.com/ArianK16a) and everyone at [@xiaomi-sm6150](https://github.com/xiaomi-sm6150), as well as the LineageOS and microG devs!
