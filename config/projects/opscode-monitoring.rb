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
maintainer 'Chef Software, Inc.'
homepage 'http://www.getchef.com'

install_path    "/opt/opscode-monitoring"
build_version Omnibus::BuildVersion.new.semver
build_iteration "1"

# setup version overrides for ruby-2.1 support
# These are from chefdk and we should check for new
# versions when chefdb has stabilized
override :berkshelf, version: "v3.0.0.beta7"
override :bundler,   version: "1.5.2"
override :libedit,   version: "20130712-3.1"
override :libtool,   version: "2.4.2"
override :libxml2,   version: "2.9.1"
override :libxslt,   version: "1.1.28"
override :nokogiri,  version: "1.6.1"
override :ruby,      version: "2.1.1"
override :rubygems,  version: "2.2.1"
override :yajl,      version: "1.2.0"
override :zlib,      version: "1.2.8"

# creates required build directories
dependency "preparation"

# global
dependency "chef-gem" # for embedded chef-solo

dependency "opscode-monitoring-cookbooks"
dependency "opscode-monitoring-scripts"
dependency "opscode-monitoring-ctl"
dependency "runit"

dependency "estatsd"
dependency "graphite"

# version manifest file
dependency "version-manifest"


exclude "\.git*"
exclude "bundler\/git"
