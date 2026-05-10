#!/bin/bash
set -e

RELEASE=0
CLEAN=0
ROOTLESS=1

usage() {
    echo "Usage: $0 [-r] [-c] [--rootful]"
    echo "  -r         Release build (strips debug symbols)"
    echo "  -c         Clean before building"
    echo "  --rootful  Build for rootful jailbreak (default: rootless)"
    exit 1
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -r) RELEASE=1 ;;
        -c) CLEAN=1 ;;
        --rootful) ROOTLESS=0 ;;
        -h|--help) usage ;;
        *) usage ;;
    esac
    shift
done

MAKE_ARGS=()

if [ $ROOTLESS -eq 1 ]; then
    MAKE_ARGS+=(THEOS_PACKAGE_SCHEME=rootless)
    echo "Scheme: rootless (iphoneos-arm64, prefix /var/jb)"
else
    echo "Scheme: rootful (iphoneos-arm)"
fi

[ $CLEAN -eq 1 ] && make clean "${MAKE_ARGS[@]}"

if [ $RELEASE -eq 1 ]; then
    MAKE_ARGS+=(FINALPACKAGE=1)
fi

make package "${MAKE_ARGS[@]}"

DEB=$(ls -t packages/*.deb 2>/dev/null | head -1)
if [ -n "$DEB" ]; then
    echo "Output: $DEB"
else
    echo "Error: no .deb found in packages/" >&2
    exit 1
fi
