#!/bin/bash
set -e

PKG="jtime"

# Find highest version
LATEST=$(ls ${PKG}_*.deb | sort -V | tail -n1)

if [[ -z "$LATEST" ]]; then
  echo "No existing package found"
  exit 1
fi

BASE=$(echo "$LATEST" | sed -E "s/${PKG}_([0-9\.]+)-([0-9]+)_.*/\1/")
REV=$(echo "$LATEST"  | sed -E "s/${PKG}_[0-9\.]+-([0-9]+)_.*/\1/")
ARCH=$(echo "$LATEST" | sed -E "s/.*_(armhf|amd64)\.deb/\1/")

NEW_REV=$((REV + 1))
NEW_DEB="${PKG}_${BASE}-${NEW_REV}_${ARCH}.deb"

echo "Latest: $LATEST"
echo "New:    $NEW_DEB"

cp "$LATEST" "$NEW_DEB"
