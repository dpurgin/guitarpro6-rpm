guitarpro6-rpm
==============

This repository contains a spec file for building an RPM package of the Linux version of Guitar Pro 6 (http://www.guitar-pro.com) for Fedora. The original package that can be downloaded from the official web site is a Debian package and is not the most comfortable thing to install in RPM-based distros.

**This repository does not contain any of actual Guitar Pro 6 files. Please use it only if you own a licensed copy of Guitar Pro 6**.

Changes against the original deb (or as if you were to install it with alien):
 * File system layout changed to follow Fedora guidelines
 * gksudo emulation via gksu-polkit (needed for GPUpdater).

## Building package

### Fedora 21, gp6-full-linux-r11621.deb

If you did not configure your system to build RPM packages [follow the guide](https://fedoraproject.org/wiki/How_to_create_an_RPM_package#Preparing_your_system).
 * Put the downloaded `gp6-full-linux-r11621.deb` into this repo
 * To prepare the RPM source run the `prepare.sh` Bash script, it will
   - Unpack the relevant parts from the Guitar Pro 6 Linux package
   - Create the directory structure
   - Download the Ubuntu Trusty OpenSSL 0.9.8 libraries
   - Put the needed components from this repo in the right place
 * Copy the generated `GuitarPro6-6.1.6.tar.bz2` into your `$RPMBUILD/SOURCE`
 * Put this repository's spec into `$RPMBUILD/SPECS`;
 * Run in SPECS dir: `QA_RPATHS=$[0x0001 | 0x0002 | 0x0004 ] rpmbuild -bb --target=i686 GuitarPro6.spec`
