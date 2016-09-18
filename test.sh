#!/bin/bash

#    Copyright 2016 Vlad Didenko
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

my_dir=$(dirname $0)
build_dir=./build
install_dir=./bin

[ -d "${build_dir}" ] || {
    echo "Missing build directory" 1>&2
    exit 1
}

[ -f "${install_dir}/aeron-driver.jar" ] || {
    echo "Missing the Aeron Media Driver script" 1>&2
    exit 1
}

java -classpath "${install_dir}/aeron-driver.jar" io.aeron.driver.MediaDriver &
media_driver_pid=$!
sleep 1

pushd "${build_dir}"
make test
popd

kill ${media_driver_pid}
