#!/bin/bash

# Remove old RStudio.app if it exists
rm -rf "${PREFIX}"/RStudio.app > /dev/null 2>&1 || true

# Copy new one
cp -r "${PREFIX}"/rstudioapp "${PREFIX}"/RStudio.app

# Patch CONDA_PREFIX LSEnvironment value
sed -i.bak "s|@CONDA_PREFIX@|${PREFIX}|g" "${PREFIX}"/RStudio.app/Contents/Info.plist
rm "${PREFIX}"/RStudio.app/Contents/Info.plist.bak

# Make a symlink. I used a shell script initially, but the icon changes to a default one
# very soon after launching for some reason (this could be the Dock icon changing code in
# RStudio itself, I am not sure..)
mkdir "${PREFIX}"/RStudio.app/Contents/MacOS
cd "${PREFIX}"/RStudio.app/Contents/MacOS
ln -s ../../../bin/rstudio rstudio
cd ../../..

# Update Apple's cached information
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -v -f RStudio.app

rm -rf "${PREFIX}"/rstudioapp
