#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "opscode-monitoring"
maintainer 'Chef, Inc.'
homepage 'http://www.getchef.com'

replaces        "opscode-monitoring"
install_path    "/opt/opscode-monitoring"
build_version Omnibus::BuildVersion.new.semver
build_iteration "1"

# creates required build directories
dependency "preparation"

# global
dependency "chef-gem" # for embedded chef-solo
#
#deps << "python"
dependency "opscode-monitoring-cookbooks"
dependency "opscode-monitoring-scripts"
dependency "opscode-monitoring-ctl"
dependency "runit"

dependency "estatsd"

# version manifest file
dependency "version-manifest"


exclude "\.git*"
exclude "bundler\/git"