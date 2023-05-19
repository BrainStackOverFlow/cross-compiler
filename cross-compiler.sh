#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export BINUTILS_VER=2.39
export GCC_VER=12.2.0
export TARGET=x86_64-elf

export PREFIX="$SCRIPT_DIR/cross"
export PATH="$PREFIX/bin:$PATH"

sudo apt-get install build-essential bison flex libgmp3-dev	libmpc-dev libmpfr-dev texinfo

wget https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VER}.tar.gz -O binutils-${BINUTILS_VER}.tar.gz
tar -xzvf binutils-${BINUTILS_VER}.tar.gz

mkdir build-binutils
cd build-binutils
../binutils-${BINUTILS_VER}/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install

wget https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-${GCC_VER}.tar.gz -O gcc-${GCC_VER}.tar.gz
tar -xzvf gcc-${GCC_VER}.tar.gz

mkdir build-gcc
cd build-gcc
../gcc-${GCC_VER}/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc
