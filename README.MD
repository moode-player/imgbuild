# moOde audio player - image builder

The image builder generates an optimized Raspberry Pi OS (RaspiOS)image with moOde audio player installed. The build is based on RaspiOS Lite Bullseye release and uses [pi-gen](https://github.com/RPi-Distro/pi-gen) to create the image.
This build process is designed to generate moode images for development and testing purposes leading up to a final release image. The release image is available for download at the [moode audio player](https://moodeaudio.org/) website.

Note: The build process will not alter the host system and thus can run on any existing host that meets the requirements listed below. If the host system behaves a little strange after a build, just reboot and it should be fine.

# The build
## Requirements

* Debian, Ubuntu or RaspiOS based system (other architectures may be added)
* At least 10GB of free disk space
* Linux friendly file system (ext4, zfs, btrfs, xfs)
* If a NAS is used for build output it should be mounted via NFS
* All packages come from the following locations:
  * Offical RaspiOS package repo
  * moOde package build repo [pkgbuild](https://github.com/moode-player/pkgbuild)
* The host used for the build should be connected via Ethernet for best download performance from the remote repos

## Output

The output is located in the subdirectory `deploy` and contains the following files:
* A zip file containing an image (.img) file
* An information (.info) file which lists all installed packages and their version numbers

Notes:
* The zip file is around 1GB in size and the image file is around 3.3GB
* The latest packages are used from the RaspiOS Lite repo in combination with specific packages from the moOde package build repo
* Make sure driver packages for moOde have been built for the particular kernel used in the image build

## Configuration

The configuration files for the build are located in the subdirectory `moode-cfg`. The [pi-gen-utils](https://github.com/FrancisTurner/pi-gen-utils) suite of utilities is used for making configuration easier.

## Important files:
* config - Contains the general configuration
* stage2_05-moode-install_01-packages - Packages that are installed onto RaspiOS but aren't built from the moOde package repo for example NGINX and PHP
* stage2_04-moode-install-prereq_00-run-chroot.sh - Prepares for package install for example setting up the moOde repo
* stage2_05-moode-install_01-packages - Packages that are installed on top the Lite distribution (Note: package dependencies are automaticly installed)
* stage3_02-moode-install-post_00-run-chroot.sh - Install rpi-update kernel, kernel drivers and configures apt-mark hold pacakges

### Configure version specific list of packages

The file `moode-cfg/stage3_01-moode-install_01-packages` contains a list of packages and provides a way to specify the exact version of each package to be installed.

Note: The moode-player package is specified in this list so it's version should be verified before performing an image build.

### Configure kernel version to be used

Currently an rpi-update kernel in used (non deb). The specific kernel to be used can be configured in `moode-cfg/stage3_02-moode-install-post_00-run-chroot.sh`

### Configure moode image version

This can be set via the IMG_NAME parameter in the file `moode-cfg/config`.

## Performing the build

Run the command below from the root directory of the imgbuild repo
```bash
./build.sh
```

Build time varies depending on system and network performance. Typical build time on Pi-4B 1GB with a Class 10 SD Card and Ethernet connection is around 1 hour.
