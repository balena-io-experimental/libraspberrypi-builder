#!/bin/bash

set -o errexit
set -o pipefail

rm -rf /$PGK_DIR/hardfp
cd /userland
bash -ex buildme /$PGK_DIR/hardfp
cd /$PGK_DIR
debuild -us -uc
cp /libraspberrypi* /output
