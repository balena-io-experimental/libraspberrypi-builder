#!/bin/bash

set -o errexit
set -o pipefail

# Remove old binaries
rm -rf /$PGK_DIR/hardfp

cd /userland
# Checkout clien-id branch
git checkout c9b848b98d20d93029c5b9493581a5c0480fb7a0
bash -ex buildme /$PGK_DIR/hardfp

# Packaging
cd /$PGK_DIR
debuild -aarmhf -us -uc
cp /libraspberrypi* /output
