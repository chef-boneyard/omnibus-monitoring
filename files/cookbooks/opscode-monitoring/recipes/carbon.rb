
graphite_dir = node['monitoring']['graphite']['base_dir']
graphite_var_dir = node['monitoring']['graphite']['var_dir']
graphite_conf_dir = File.join(graphite_var_dir, "conf")
graphite_storage_dir = node['monitoring']['graphite']['storage_dir']
carbon_log_dir = node['monitoring']['carbon']['log_directory']

[
  graphite_storage_dir,
  graphite_dir,
  graphite_var_dir,
  graphite_conf_dir,
  carbon_log_dir
].each do |dir_name|
  directory dir_name do
    owner node['monitoring']['user']['username']
    mode '0700'
    recursive true
  end
end

%w{ log whisper rrd }.each do |dir|
  directory "#{graphite_storage_dir}/#{dir}" do
    owner node['monitoring']['user']['username']
  end
end

template "#{graphite_conf_dir}/carbon.conf" do
  owner node['monitoring']['user']['username']
  carbon_options = node['monitoring']['carbon'].dup
  variables(
    :storage_dir => graphite_storage_dir,
    :carbon_options => carbon_options
  )
  notifies :restart, 'service[carbon-cache]'
end

template "#{graphite_conf_dir}/storage-schemas.conf" do
  source 'storage.conf.erb'
  owner node['monitoring']['user']['username']
  variables(:storage_config => node['monitoring']['graphite']['storage_schemas'])
  only_if { node['monitoring']['graphite']['storage_schemas'].is_a?(Array) }
  notifies :restart, 'service[carbon-cache]'
end

if node['monitoring']['graphite']['storage_aggregation'].is_a?(Array) &&
   node['monitoring']['graphite']['storage_aggregation'].length > 0
  template "#{graphite_conf_dir}/storage-aggregation.conf" do
    source 'storage.conf.erb'
    owner node['monitoring']['user']['username']
    variables(:storage_config => node['monitoring']['graphite']['storage_aggregation'])
    notifies :restart, 'service[carbon-cache]'
  end
else
  file "#{graphite_conf_dir}/storage-aggregation.conf" do
    action :delete
    notifies :restart, 'service[carbon-cache]'
  end
end

component_runit_service "carbon-cache" do
  log_directory  node['monitoring']['carbon']['log_directory']
  svlogd_size    node['monitoring']['carbon']['log_rotation']['file_maxbytes']
  svlogd_num     node['monitoring']['carbon']['log_rotation']['num_to_keep']
  ha             node['monitoring']['carbon']['ha']
  finish         true
end

if node['monitoring']['bootstrap']['enable']
  execute "/opt/opscode-monitoring/bin/opscode-monitoring-ctl start carbon-cache" do
    retries 20
  end
end



