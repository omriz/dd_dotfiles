#!/usr/bin/env bash
$(cd $(dirname "$0") && pwd)/install_helper.sh 2>&1 | tee ~/install.log
