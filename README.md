# README #

This program queries the Yahoo geolocation database.

## Installation

Issue

	``make install``

If you want another installation prefix just set the PREFIX variable

	``make PREFIX="$HOME/local" install``

Variables that can be changed in this way:

PREFIX
	Default: /usr/local

AWKLIB
	The directory where getxml.awk can be found. (Default: $PREFIX/share/awklib)

SHLIB
	The directory where urlencode.sh can be found. (Default: $PREFIX/share/shlib)

AWKFILE_DIR
	The path where location.awk will be installed. (Default: $PREFIX/share/location)

MANDIR
	The directory where location.1 will be installed. (Default: $PREFIX/share/man/man1)

## Documentation ##

See the manpage location.1 for details.
