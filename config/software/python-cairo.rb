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

name "python-cairo"
default_version "1.10.0"

dependency "python"
dependency "pip"
dependency "cairo"

source :url => "http://www.cairographics.org/releases/py2cairo-#{version}.tar.bz2",
       :md5 => "20337132c4ab06c1146ad384d55372c5"

relative_path "py2cairo-1.10.0"

build do
  cmd = ["#{install_dir}/embedded/bin/python",
         "./waf",
         "--prefix=#{install_dir}/embedded",
         "configure"
        ].join(" ")
  env = {
    "PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}",
    "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
    "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
    "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
    "PKG_CONFIG_PATH" => "#{install_dir}/embedded/lib/pkgconfig"
  }
  command cmd, :env => env
  command "#{install_dir}/embedded/bin/python ./waf build"
  command "#{install_dir}/embedded/bin/python ./waf install"
end

