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

name "opscode-monitoring-cookbooks"

dependency "rsync"
dependency "berkshelf"

project_name = project.name

source :path => File.expand_path("files/cookbooks/#{project_name}", Omnibus::Config.project_root)

build do
  command "mkdir -p #{install_dir}/embedded/cookbooks"
  command "#{install_dir}/embedded/bin/berks vendor --berksfile=./Berksfile #{install_dir}/embedded/cookbooks",
          :env => { "RUBYOPT"         => nil,
                    "BUNDLE_BIN_PATH" => nil,
                    "BUNDLE_GEMFILE"  => nil,
                    "GEM_PATH"        => nil,
                    "GEM_HOME"        => nil }
  block do
    File.open("#{install_dir}/embedded/cookbooks/dna.json", "w") do |f|
      f.puts "{\"run_list\": [ \"recipe[#{project_name}]\" ]}"
    end
    File.open("#{install_dir}/embedded/cookbooks/show-config.json", "w") do |f|
      f.puts "{\"run_list\": [ \"recipe[#{project_name}::show_config]\" ]}"
    end
    File.open("#{install_dir}/embedded/cookbooks/solo.rb", "w") do |f|
      f.puts "CURRENT_PATH = File.expand_path(File.dirname(__FILE__))"
      f.puts "file_cache_path \"\#\{CURRENT_PATH\}/cache\""
      f.puts "cookbook_path CURRENT_PATH"
      f.puts "verbose_logging true"
      f.puts "ssl_verify_mode :verify_peer"
    end
  end
end
