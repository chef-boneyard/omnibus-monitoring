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
default['monitoring']['etc_path'] = "/etc/opscode-monitoring"
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
default['monitoring']['estatsd']['ha'] = false
default['monitoring']['estatsd']['dir'] = "/var/opt/opscode-monitoring/estatsd"
default['monitoring']['estatsd']['log_directory'] = "/var/log/opscode-monitoring/estatsd"
default['monitoring']['estatsd']['log_rotation']['file_maxbytes'] = 104857600
default['monitoring']['estatsd']['log_rotation']['num_to_keep'] = 10

default['monitoring']['estatsd']['udp_listen_port'] = 9466
default['monitoring']['estatsd']['udp_recbuf'] = 524288
default['monitoring']['estatsd']['udp_max_batch_size'] = 100
default['monitoring']['estatsd']['udp_max_batch_age'] = 2000
default['monitoring']['estatsd']['graphite_port'] = 2003
default['monitoring']['estatsd']['graphite_host'] = '127.0.0.1'
default['monitoring']['estatsd']['flush_interval'] = 10000

#
# General graphite configuration (used across components)
default['monitoring']['graphite']['base_dir'] = '/opt/opscode-monitoring/embedded'
default['monitoring']['graphite']['var_dir'] = '/var/opt/opscode-monitoring/graphite'
default['monitoring']['graphite']['doc_root'] = '/opt/opscode-monitoring/embedded/service/graphite/webapp'
default['monitoring']['graphite']['storage_dir'] = '/var/opt/opscode-monitoring/graphite/storage'
default['monitoring']['graphite']['timezone'] = 'America/Los_Angeles'
default['monitoring']['graphite']['django_root'] = '@DJANGO_ROOT@'
default['monitoring']['graphite']['storage_schemas'] = [
  # 10s:1h,1m:1d,10m:30d,1h:1y,1d:5y (200536 bytes)'
  {
    'name' => 'catchall',
    'pattern' => '^.*',
    'retentions' => '10:360,60:1440,600:4320,3600:8760,86400:1825'
  }
]
default['monitoring']['graphite']['storage_aggregation'] = nil

# Carbon (Graphite)
default['monitoring']['carbon']['enable'] = true
default['monitoring']['carbon']['ha'] = false
default['monitoring']['carbon']['log_directory'] = "/var/log/opscode-monitoring/carbon-cache"
default['monitoring']['carbon']['log_rotation']['file_maxbytes'] = 104857600
default['monitoring']['carbon']['log_rotation']['num_to_keep'] = 10
default['monitoring']['carbon']['line_receiver_interface'] =   '0.0.0.0'
default['monitoring']['carbon']['line_receiver_port'] = 2003
default['monitoring']['carbon']['enable_udp_listener'] = 'False'
default['monitoring']['carbon']['udp_receiver_interface'] = '0.0.0.0'
default['monitoring']['carbon']['udp_receiver_port'] = 2003
default['monitoring']['carbon']['pickle_receiver_interface'] = '0.0.0.0'
default['monitoring']['carbon']['pickle_receiver_port'] = 2004
default['monitoring']['carbon']['use_insecure_unpickler'] = 'False'
default['monitoring']['carbon']['cache_query_interface'] =     '0.0.0.0'
default['monitoring']['carbon']['cache_query_port'] = 7002
default['monitoring']['carbon']['use_flow_control'] = 'True'
default['monitoring']['carbon']['max_cache_size'] = 'inf'
default['monitoring']['carbon']['max_creates_per_second'] = 'inf'
default['monitoring']['carbon']['max_updates_per_second'] = '1000'
default['monitoring']['carbon']['log_whisper_updates'] = 'False'
default['monitoring']['carbon']['whisper_autoflush'] = 'False'


# Carbon relay
default['monitoring']['graphite']['relay_rules'] = []
default['monitoring']['carbon']['relay']['line_receiver_interface'] = '0.0.0.0'
default['monitoring']['carbon']['relay']['line_receiver_port'] = 2013
default['monitoring']['carbon']['relay']['pickle_receiver_interface'] = '0.0.0.0'
default['monitoring']['carbon']['relay']['pickle_receiver_port'] = 2014
default['monitoring']['carbon']['relay']['udp_receiver_interface'] = '0.0.0.0'
default['monitoring']['carbon']['relay']['udp_receiver_port'] = 2003
default['monitoring']['carbon']['relay']['method'] = 'rules' # rules | consistent-hashing
default['monitoring']['carbon']['relay']['replication_factor'] = 1
default['monitoring']['carbon']['relay']['destinations'] = []
default['monitoring']['carbon']['relay']['max_datapoints_per_message'] = 500
default['monitoring']['carbon']['relay']['max_queue_size'] = 10000
default['monitoring']['carbon']['relay']['use_flow_control'] = 'True'

# Carbon Aggregator
default['monitoring']['graphite']['aggregation_rules'] = []
default['monitoring']['carbon']['aggregator']['line_receiver_interface'] = '0.0.0.0'
default['monitoring']['carbon']['aggregator']['line_receiver_port'] = 2023
default['monitoring']['carbon']['aggregator']['pickle_receiver_interface'] = '0.0.0.0'
default['monitoring']['carbon']['aggregator']['pickle_receiver_port'] = 2024
default['monitoring']['carbon']['aggregator']['destinations'] = []
default['monitoring']['carbon']['aggregator']['replication_factor'] = 1
default['monitoring']['carbon']['aggregator']['max_queue_size'] = 10000
default['monitoring']['carbon']['aggregator']['use_flow_control'] = 'True'
default['monitoring']['carbon']['aggregator']['max_datapoints_per_message'] = 500
default['monitoring']['carbon']['aggregator']['max_aggregation_intervals'] = 5


#
# graphite_web
#

default['monitoring']['graphite_web']['enable'] = false
default['monitoring']['graphite_web']['ha'] = false
default['monitoring']['graphite_web']['debug'] = 'False'
default['monitoring']['graphite_web']['admin_email'] = 'admin@example.com'
#default['monitoring']['graphite_web']['cluster_servers'] = []
#default['monitoring']['graphite_web']['carbonlink_hosts'] = []
#default['monitoring']['graphite_web']['memcached_hosts'] = ['127.0.0.1:11211']
default['monitoring']['graphite_web']['database']['NAME'] = node['monitoring']['graphite']['storage_dir']+"/graphite.db"
default['monitoring']['graphite_web']['database']['ENGINE'] = "django.db.backends.sqlite3"
default['monitoring']['graphite_web']['database']['USER'] = ""
default['monitoring']['graphite_web']['database']['PASSWORD'] = ""
default['monitoring']['graphite_web']['database']['HOST'] = ""
default['monitoring']['graphite_web']['database']['PORT'] = ""
default['monitoring']['graphite_web']['email']['BACKEND'] = "django.core.mail.backends.smtp.EmailBackend"
default['monitoring']['graphite_web']['email']['HOST'] = "localhost"
default['monitoring']['graphite_web']['email']['PORT'] = "25"
default['monitoring']['graphite_web']['email']['HOST_USER'] = ""
default['monitoring']['graphite_web']['email']['HOST_PASSWORD'] = ""
default['monitoring']['graphite_web']['email']['USE_TLS'] = false
default['monitoring']['graphite_web']['bitmap_support'] = true


