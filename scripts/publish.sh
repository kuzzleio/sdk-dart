#!/bin/bash

set -e

# Extract version line from pubspec.yaml
VERSION_LINE=$(grep '^version: ' pubspec.yaml)
VERSION=$(echo "$VERSION_LINE" | sed 's/version: //')

# Split version into main and build parts
MAIN_VERSION=$(echo "$VERSION" | cut -d'+' -f1)
BUILD_VERSION=$(echo "$VERSION" | cut -s -d'+' -f2)

# Split main version into major, minor, patch
IFS='.' read -r MAJOR MINOR PATCH <<< "$MAIN_VERSION"

# Increment patch
PATCH=$((PATCH + 1))

# Reconstruct new version
NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"
if [ -n "$BUILD_VERSION" ]; then
  NEW_VERSION="${NEW_VERSION}+${BUILD_VERSION}"
fi

# Update pubspec.yaml
sed -i "s/^version: .*/version: ${NEW_VERSION}/" pubspec.yaml

# Commit changes
git add pubspec.yaml
git commit -m "Release $NEW_VERSION [skip ci]"
git push origin master

# Git tag and push
git tag -a "$NEW_VERSION" -m "Release $NEW_VERSION"
git push origin "$NEW_VERSION"