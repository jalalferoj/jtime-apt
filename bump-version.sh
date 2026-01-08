#!/bin/bash
# Extract the current version from the Packages file
CURRENT_VERSION=$(grep "Version:" Packages | head -n 1 | awk '{print $2}')

if [ -z "$CURRENT_VERSION" ]; then
    NEW_VERSION="1.0-1"
else
    # Split 1.0-1 into '1.0' and '1'
    BASE=$(echo $CURRENT_VERSION | cut -d'-' -f1)
    REV=$(echo $CURRENT_VERSION | cut -d'-' -f2)
    # Increment the revision number
    NEW_REV=$((REV + 1))
    NEW_VERSION="$BASE-$NEW_REV"
fi

echo "Updating version to $NEW_VERSION"
# This ensures the local file matches the new versioning
sed -i "s/Version: .*/Version: $NEW_VERSION/" Packages
