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

# Create the package directory structure
mkdir -p $OUT_DIR/$APP_NAME/usr/bin

# Copy the executable to the package directory
cp dist/$APP_NAME $OUT_DIR/$APP_NAME/usr/bin

# Create the PKGBUILD file
echo "pkgname=$APP_NAME" > PKGBUILD
echo "pkgver=1.0" >> PKGBUILD
echo "pkgrel=1" >> PKGBUILD
echo "arch=('x86_64')" >> PKGBUILD
echo "url='https://example.com'" >> PKGBUILD
echo "license=('MIT')" >> PKGBUILD
echo "depends=('python')" >> PKGBUILD
echo "source=('$APP_NAME')" >> PKGBUILD
echo "package()" >> PKGBUILD
echo "{" >> PKGBUILD
echo "  cd \$srcdir" >> PKGBUILD
echo "  install -Dm755 $APP_NAME/usr/bin/$APP_NAME \$pkgdir/usr/bin/$APP_NAME" >> PKGBUILD
echo "}" >> PKGBUILD

# Create the package
makepkg -f

# Clean up
rm -r $OUT_DIR
rm PKGBUILD

echo "Package built in $(pwd)/$APP_NAME-1.0-1-x86_64.pkg.tar.zst"