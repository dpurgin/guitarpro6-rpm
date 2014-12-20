guitarpro6-rpm
==============

This repository contains a spec file for building an RPM package of the Linux version of Guitar Pro 6 (http://www.guitar-pro.com) for Fedora. The original package that can be downloaded from the official web site is a Debian package and is not the most comfortable thing to install in RPM-based distros.

*This repository does not contain any of actual Guitar Pro 6 files. Please use it only if you own a license copy of Guitar Pro 6*.

Changes against the original deb (or as if you were to install it with alien):
 * File system layout changed to follow Fedora guidelines;
 * Prebuilt OpenSSL 0.9.8zc included;
 * gksudo emulation via gksu-polkit (needed for GPUpdater).

##Building package

###Fedora 21, gp6-full-linux-r11621.deb

[Prepare your system](https://fedoraproject.org/wiki/How_to_create_an_RPM_package#Preparing_your_system) for building RPM packages. 
 * Unpack deb contents somewhere;
 * Move unpacked ```data/opt/GuitarPro6``` to ```$RPMBUILD/SOURCES/GuitarPro-6.1.6/usr/lib/GuitarPro6```;
 * Merge this repository's contents with ```$RPMBUILD/SOURCES/GuitarPro-6.1.6``` overwriting existing files;
 * In ```$RPMBUILD/SOURCES``` make ```GuitarPro-6.1.6.tar.bz2``` containing ```$RPMBUILD/SOURCES/GuitarPro-6.1.6``` on top;
 * Put this repository's spec to ```$RPMBUILD/SPECS/GuitarPro6.spec```;
 * Run in SPECS dir: ```$ QA_RPATHS=$[0x0001 | 0x0002 | 0x0004 ] rpmbuild -bb GuitarPro6.spec```
