#
# Copyright:: Copyright (c) 2014 Chef Software, Inc.
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

estatsd_dir = node['monitoring']['estatsd']['dir']
estatsd_etc_dir = File.join(estatsd_dir, "etc")
estatsd_log_dir = node['monitoring']['estatsd']['log_directory']
estatsd_sasl_log_dir = File.join(estatsd_log_dir, "sasl")
[
  estatsd_dir,
  estatsd_etc_dir,
  estatsd_log_dir,
  estatsd_sasl_log_dir
].each do |dir_name|
  directory dir_name do
    owner node['monitoring']['user']['username']
    mode '0700'
    recursive true
  end
end

link "#{node['monitoring']['install_path']}/embedded/service/estatsd/log" do
  to estatsd_log_dir
end

template "#{node['monitoring']['install_path']}/embedded/service/estatsd/bin/estatsd" do
  source "estatsd.erb"
  owner "root"
  group "root"
  mode "0755"
  variables(node['monitoring']['estatsd'].to_hash)
  notifies :restart, 'service[estatsd]' if OmnibusHelper.should_notify?("estatsd")
end

estatsd_config = File.join(estatsd_etc_dir, "app.config")

template estatsd_config do
  source "estatsd.config.erb"
  mode "644"
  variables(node['monitoring']['estatsd'].to_hash)
  notifies :restart, 'service[estatsd]' if OmnibusHelper.should_notify?("estatsd")
end

link "#{node['monitoring']['install_path']}/embedded/service/estatsd/etc/sys.config" do
  to estatsd_config
end

component_runit_service "estatsd" do
  log_directory  node['monitoring']['estatsd']['log_directory']
  svlogd_size    node['monitoring']['estatsd']['log_rotation']['file_maxbytes']
  svlogd_num     node['monitoring']['estatsd']['log_rotation']['num_to_keep']
  ha             node['monitoring']['estatsd']['ha']
end

if node['monitoring']['bootstrap']['enable']
  execute "#{node['monitoring']['install_path']}/bin/opscode-monitoring-ctl start estatsd" do
    retries 20
  end
end


