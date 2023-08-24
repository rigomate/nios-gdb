#!/bin/bash

gdbVersion="11.2"

wget https://ftp.gnu.org/gnu/gdb/gdb-${gdbVersion}.tar.xz
tar -xf gdb-${gdbVersion}.tar.xz
pushd gdb-${gdbVersion}

./configure --target=nios2-elf --with-python
make all-gdb -j$(nproc)

popd

mkdir assets
cp ./gdb-${gdbVersion}/gdb/gdb.exe assets/
cp /mingw64/bin/libc++.dll assets/
cp /mingw64/bin/libgcc_s_seh-1.dll assets/
cp /mingw64/bin/libgmp-10.dll assets/
cp /mingw64/bin/libiconv-2.dll assets/
cp /mingw64/bin/libintl-8.dll assets/
cp /mingw64/bin/libmpfr-6.dll assets/
cp /mingw64/bin/libncursesw6.dll assets/
cp /mingw64/bin/libpython3.10.dll assets/
cp /mingw64/bin/libstdc++-6.dll assets/
cp /mingw64/bin/libxxhash.dll assets/

tar -zcvf assets.tar.gz assets
