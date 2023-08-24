#!/bin/bash

gdbVersion="11.2"

wget https://ftp.gnu.org/gnu/gdb/gdb-${gdbVersion}.tar.xz
tar -xf gdb-${gdbVersion}.tar.xz

pushd gdb-${gdbVersion}
echo "[i] configuring"
./configure --target=nios2-elf --with-python --without-auto-load-safe-path --with-gdb-datadir=c:/intelfpga_lite/22.1std/nios2eds/bin/gnu/h-x86_64-mingw32/nios2-elf/share/gdb
echo "[i] starting build"
make all-gdb -j$(nproc)
strip gdb/gdb.exe
popd


echo "[i] copying data directory"
mkdir -p assets/intelFPGA_lite/22.1std/nios2eds/bin/gnu/H-x86_64-mingw32/nios2-elf/share/gdb
cp -r ./gdb-${gdbVersion}/gdb/data-directory/python ./assets/intelFPGA_lite/22.1std/nios2eds/bin/gnu/H-x86_64-mingw32/nios2-elf/share/gdb

echo "[i] copying gdb.exe and .dll files"
mkdir -p assets/intelFPGA_lite/22.1std/nios2eds/bin/gnu/H-x86_64-mingw32/bin
cp ./gdb-${gdbVersion}/gdb/gdb.exe ./assets/intelFPGA_lite/22.1std/nios2eds/bin/gnu/H-x86_64-mingw32/bin
cp /mingw64/bin/*.dll ./assets/intelFPGA_lite/22.1std/nios2eds/bin/gnu/H-x86_64-mingw32/bin

pushd assets
echo "[i] tarballing final artifact"
tar -cJf ../nios-gdb.tar.xz .
popd
