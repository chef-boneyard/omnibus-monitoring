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

install_path = node['monitoring']['install_path']

node.set['runit']['sv_bin']       = "#{install_path}/embedded/bin/sv"
node.set['runit']['chpst_bin']    = "#{install_path}/embedded/bin/chpst"
node.set['runit']['service_dir']  = "#{install_path}/service"
node.set['runit']['sv_dir']       = "#{install_path}/sv"
node.set['runit']['lsb_init_dir'] = "#{install_path}/init"

case node['platform_family']
when 'debian'
  include_recipe 'opscode-monitoring::runit_upstart'
when 'rhel'
  if node['platform_version'] =~ /^6/
    include_recipe 'opscode-monitoring::runit_upstart'
  else
    include_recipe 'opscode-monitoring::runit_sysvinit'
  end
else
  include_recipe 'opscode-monitoring::runit_sysvinit'
end
