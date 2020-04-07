#!/bin/bash

BASE_DIR="."
BUILD_DIR=$BASE_DIR/Build
ARCHIVE_PATH=$BUILD_DIR/FormatterExtension.xcarchive
APP_PATH=$BUILD_DIR/FormatterExtension.app

echo "Updating Submodules"
git submodule update --init --recursive
cd swift-format
swift package generate-xcodeproj
cd ..

echo "Building FormatterExtension..."

echo "Cleaning up old archive & app..."
rm -rf $ARCHIVE_PATH $APP_PATH

echo "Building archive..."
xcodebuild -project $BASE_DIR/FormatterExtension.xcodeproj -config Release -scheme FormatterExtension -archivePath $ARCHIVE_PATH archive

echo "Exporting archive..."
xcodebuild -archivePath $ARCHIVE_PATH -exportArchive -exportPath $APP_PATH -exportFormat app

echo "Cleaning up archive..."
rm -rf $ARCHIVE_PATH

echo "Done"