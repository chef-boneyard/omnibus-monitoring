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

###
# High level options
###
default['monitoring']['install_path'] = "/opt/opscode-monitoring"
default['monitoring']['bootstrap']['enable'] = true

####
# The User that services run as
####
# The username for the monitoring services user
default['monitoring']['user']['username'] = "opscode"
# The shell for the monitoring services user
default['monitoring']['user']['shell'] = "/bin/sh"
# The home directory for the monitoring services user
default['monitoring']['user']['home'] = "/opt/opscode/embedded"

default['monitoring']['estatsd']['enable'] = true
default['monitoring']['estatsd']['dir'] = "/var/opt/opscode-monitoring/estatsd"
default['monitoring']['estatsd']['log_directory'] = "/var/log/opscode-monitoring/estatsd"
default['monitoring']['estatsd']['svlogd_size'] = 1000000
default['monitoring']['estatsd']['svlogd_num'] = 10

default['monitoring']['estatsd']['udp_listen_port'] = 3344
default['monitoring']['estatsd']['udp_recbuf'] = 524288
default['monitoring']['estatsd']['udp_max_batch_size'] = 100
default['monitoring']['estatsd']['udp_max_batch_age'] = 2000
default['monitoring']['estatsd']['udp_listen_port'] = 10000
default['monitoring']['estatsd']['graphite_port'] = 2003
default['monitoring']['estatsd']['graphite_host'] = '127.0.0.1'
default['monitoring']['estatsd']['flush_interval'] = 10000

