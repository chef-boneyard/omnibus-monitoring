#
# Copyright:: Copyright (c) 2013 Opscode, Inc.
#
# All Rights Reserved
#

template "/etc/init/opscode-monitoring-runsvdir.conf" do
  owner "root"
  group "root"
  mode "0644"
  variables({
      :install_path => "/opt/opscode-monitoring"
  })
  source "init-runsvdir.erb"
end

# Keep on trying till the job is found :(
execute "initctl status opscode-monitoring-runsvdir" do
  retries 30
end

# If we are stop/waiting, start
#
# Why, upstart, aren't you idempotent? :(
execute "initctl start opscode-monitoring-runsvdir" do
  only_if "initctl status opscode-monitoring-runsvdir | grep stop"
  retries 30
end
