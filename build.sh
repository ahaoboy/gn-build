#!/bin/bash

if [ $# -ne 1 ]; then
    echo "not found target"
    exit 1
fi

TARGET=$1

git clone https://gn.googlesource.com/gn gn
cd gn

git apply  ../001-build-fixes.patch
git apply  ../003-remove-msvc-flags.patch
git apply  ../004-add-arm64-arch.patch

python3 build/gen.py

ninja -C out

mkdir ../dist

ls -lh out

cp -r out/gn* ../dist

cd ..

ls -lh dist

tar -czf ./gn-${TARGET}.tar.gz -C dist .
ls -l ./gn-${TARGET}.tar.gz