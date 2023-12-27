#!/bin/bash

# Set the name of the executable and the output directory
APP_NAME=TextEditor
OUT_DIR=dist

# Create the output directory if it doesn't exist
if [ ! -d "$OUT_DIR" ]; then
  mkdir $OUT_DIR
fi

# Use PyInstaller to create the executable
pyinstaller --name=$APP_NAME --onefile text_editor.py

# Create the Debian package control file
echo "Package: $APP_NAME" > control
echo "Version: 1.0" >> control
echo "Section: base" >> control
echo "Priority: optional" >> control
echo "Architecture: all" >> control
echo "Depends: python3" >> control
echo "Maintainer: Your Name <youremail@example.com>" >> control
echo "Description: A simple text editor." >> control

# Create the Debian package
mkdir -p $OUT_DIR/DEBIAN
cp control $OUT_DIR/DEBIAN
cp dist/$APP_NAME $OUT_DIR/usr/bin
dpkg-deb --build $OUT_DIR

# Clean up
rm control
rm -r dist
rm -r build

echo "Package built in $OUT_DIR/$APP_NAME.deb"