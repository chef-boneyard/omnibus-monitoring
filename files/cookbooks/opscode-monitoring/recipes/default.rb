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

require 'openssl'

ENV['PATH'] = "#{node['monitoring']['install_path']}/bin:#{node['monitoring']['install_path']}/embedded/bin:#{ENV['PATH']}"

directory "/etc/opscode-monitoring" do
  owner "root"
  group "root"
  mode "0775"
  action :nothing
end.run_action(:create)

# We need to load the private chef configuration
if File.exists?("/etc/opscode/chef-server-running.json")
  private_chef = JSON.parse(IO.read("/etc/opscode/chef-server-running.json"))
end
node.consume_attributes({"private_chef" => private_chef['private_chef']})

Monitoring[:node] = node
if File.exists?("/etc/opscode-monitoring/opscode-monitoring.rb")
  Monitoring.from_file("/etc/opscode-monitoring/opscode-monitoring.rb")
end
node.consume_attributes(Monitoring.generate_config(node['fqdn']))

if File.exists?("/var/opt/opscode-monitoring/bootstrapped")
  node.set['monitoring']['bootstrap']['enable'] = false
end

# Create the Chef User
include_recipe "opscode-monitoring::users"

directory "/var/opt/opscode-monitoring" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

# Configure and install our runit instance
include_recipe "enterprise::runit"

# Configure Services
[
  "estatsd",
  "bootstrap"
].each do |service|
  if node["monitoring"][service]["enable"]
    include_recipe "opscode-monitoring::#{service}"
  else
    include_recipe "opscode-monitoring::#{service}_disable"
  end
end

file "/etc/opscode-monitoring/opscode-monitoring-running.json" do
  owner node['monitoring']['user']['username']
  group "root"
  mode "0644"
  content Chef::JSONCompat.to_json_pretty({ "monitoring" => node['monitoring'].to_hash, "run_list" => node.run_list })
end
