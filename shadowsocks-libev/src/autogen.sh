#!/bin/sh

# On macOS, we need to point aclocal to the directory where Homebrew's
# libtool macros are installed.
if [ -d "/usr/local/share/aclocal" ]; then
    ACLOCAL_PATH="/usr/local/share/aclocal"
    export ACLOCAL_PATH
fi

autoreconf --install --force
