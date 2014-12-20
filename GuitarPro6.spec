Name: GuitarPro6
Version: 6.1.6
Release: 1%{?dist}
Summary: Guitar Pro 6, Linux Version
License: Proprietary
Source0: %{name}-%{version}.tar.bz2
URL: http://www.guitar-pro.com
Requires: gksu-polkit

%global _privatelibs lib(GPCore|OverLoud|PickupModeling|QtCore|QtDBus|QtGui|QtNetwork|QtOpenGL|QtSvg|QtWebKit|QtXml|QtXmlPatterns|RSEAudioCore|RSECore|WavFile|Zip|boost_date_time-gcc43-mt-1_39|boost_filesystem-gcc43-mt-1_39|boost_regex-gcc43-mt-1_39|boost_system-gcc43-mt-1_39|boost_thread-gcc43-mt-1_39|chunk|crypto|exception|factory|filesystem|memory|mmap|object|phonon|profiler|register|ssl|thread|timer|variant|xml)\\.so
%global __provides_exclude %{_privatelibs}
%global __requires_exclude %{_privatelibs}

%description
Guitar Pro is a musical software program offering all of the functionalities 
that all guitarists need.

* Edit, visualize, and share your scores

* Learn to play or improve your technique

* Accompany yourself by creating the instrumental tracks of your choice

* Enjoy a series of essential tools: scale-validating tool, tuner, metronome,
  guitar fretboard...

Now is your turn to play!

%changelog 
* Sat Dec 20 2014 Dmitriy Purgin <dpurgin@gmail.com> 6.1.5-1
- Repackaged from original .deb

%prep
%setup -q

%build

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}

cp -a * %{buildroot}

%files
%defattr(-,root,root)
%{_bindir}/*
%{_libdir}/%{name}/
%{_datadir}/applications/%{name}.desktop
%{_datadir}/pixmaps/guitarpro6.png


