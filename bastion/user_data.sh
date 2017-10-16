#!/usr/bin/env bash

set -e
cat <<EOF > foo
Host *
  IdentityFile ~/.ssh/bossa-key.pem
  User ubuntu
EOF
