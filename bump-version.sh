#!/bin/bash
set -e

# 1. Get current version from the Packages file
CURRENT_VERSION=$(grep "Version:" Packages | head -n 1 | awk '{print $2}')

if [ -z "$CURRENT_VERSION" ]; then
    echo "Could not find version in Packages file. Defaulting to 1.0-1"
    NEW_VERSION="1.0-1"
else
    # 2. Extract Base (1.0) and Revision (1)
    BASE=$(echo $CURRENT_VERSION | cut -d'-' -f1)
    REV=$(echo $CURRENT_VERSION | cut -d'-' -f2)
    NEW_REV=$((REV + 1))
    NEW_VERSION="$BASE-$NEW_REV"
fi

echo "Bumping version to $NEW_VERSION"

# 3. Update the Packages file version
sed -i "s/Version: .*/Version: $NEW_VERSION/" Packages

# 4. Update the filename reference in Packages (important for APT)
sed -i "s/Filename: .\/jtime_.*\.deb/Filename: .\/jtime_$NEW_VERSION\_armhf.deb/" Packages
