#!/bin/bash

echo "Updating Submodules"
git submodule update --init --recursive
cd swift-format
swift package generate-xcodeproj
cd ..

xed .