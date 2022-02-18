# moOde audio player - image builder

The moOde audio player imgbuild project generates a fully automated a custom Raspberry Pi OS image with the moOde audio player installed. The build is based on Raspberry Pi OS Lite (Bullseye) and generated with the [pi-gen](https://github.com/RPi-Distro/pi-gen).
Unless you are developing a new moode image, you don't need to generate the image yourself, you can download a prebuild image from the [moode audio player](https://moodeaudio.org/) website.

The build will not alter the host system, so you if want you can running it from an existing system.
If your system behaves a little strange after a build, just reboot an you will be fine.

# The build
## Requirements

* Debian/Ubuntu/Raspberry OS system (pi-gen should support builds on another architecture ).
* At least 10GB free space
  * If network storage is mounted is should be a linux friendly file system. No NTFS or SMB.
* All the packages to install should be located:
  * Offical Raspberry Pi OS bullseye repo
  * The moode audio player repo
* Internet connection, preferably via Ethernet


## The output

The output will be:
* An zip tha contains an img file.
* An info file wich list all installed packages including version number.

At the moment of writing the zip will be just around the 1GB, with an img file of arround 3.3GB.

It is located in the subdir `dist`.

The build is based on top of Raspberry Pi Lite Bullseye in combination with the specific moode packages from the moode [pkgbuild](https://github.com/moode-player/pkgbuild) project.
The build the latest available packages of Bullseye will be used.
Make sure that moode driver packages are available for the used kernel.

## Configuration

The configuration files for the build can be found in the subdir `moode-cfg`.

THe [pi-gen-utils](https://github.com/FrancisTurner/pi-gen-utils) project is used for making it easier to configure.

important files:
* config - contains general config
* stage2_04-moode-install-prereq_00-run-chroot.sh - prepare for install, like setting up the moode repo
* stage2_05-moode-install_01-packages - packages that should be installed on top the lite distribution, deps of the mentioned packages are automatic installed
* stage2_06-moode-install-post_00-run-chroot.sh - post steps like locking important packages

There is also a second cfg dir `moode-base-cfg` this one is used to generated moode image with everything expect the moode-player it self.
This makes it easier to test clean systems during development.

## Performing the build

Run from the root of the project
```bash
./build.sh
```

Expect somewhere around the 35+ minutes of a Raspberry Pi 4 4GB (with NFS network storage).
