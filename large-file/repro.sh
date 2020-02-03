#!/bin/sh

set -e -x

sudo snap install multipass --classic || true
sudo snap install snapcraft --classic || true

if [ ! -f data/large-file ]; then
  mkdir -p data
  dd if=/dev/zero of=data/large-file bs=1M count=10000
fi

export SNAPCRAFT_BUILD_ENVIRONMENT_DISK="64G"
export SNAPCRAFT_BUILD_ENVIRONMENT="multipass"

while true; do
  for i in $(seq 1 1200); do
    sleep $i
    snapcraft
  done
done
