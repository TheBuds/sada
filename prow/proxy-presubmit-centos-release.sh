#!/bin/bash
#
# Copyright 2017 Istio Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

WD=$(dirname "$0")
WD=$(cd "$WD" || exit 1 ; pwd)

#######################################
# Presubmit script triggered by Prow. #
#######################################

# Do not use RBE execution with Ubuntu toolchain, but still use RBE cache.
export BAZEL_BUILD_RBE_JOBS=0

# shellcheck disable=SC1090,SC1091
source "${WD}/proxy-common.inc"

echo "$(uname -s)-$(uname -m)"
cat "${WD}/../WORKSPACE"
echo 'Run tests'
make test_centos

echo 'Test building release artifacts'
make test_release_centos
