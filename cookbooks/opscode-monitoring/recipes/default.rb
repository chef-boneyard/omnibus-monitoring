#
# Cookbook Name:: opscode-monitoring
# Recipe:: default
#
# Copyright (C) 2014 Chef Software, Inc.
#
# All rights reserved - Do Not Redistribute
#

unless node['omnibus']['build_dir']
  raise "You must set a value for node['omnibus']['build_dir']!"
end

unless node['omnibus']['project']
  raise "You must set a value for node['omnibus']['project']!"
end

# If we have a git cache locally, copy it into place. We don't use git
# clone because on a first build we won't yet have git available.
# FIXME: right now only workes for a hardcoded platform :(
git_cache_dir = "/var/cache/omnibus/cache/git_cache/opt/opscode-monitoring"
directory git_cache_dir do
  recursive true
  only_if "test -d /home/vagrant/opscode-monitoring/ubuntu-1204_git_cache"
end

execute "cp -R /home/vagrant/opscode-monitoring/ubuntu-1204_git_cache/* #{git_cache_dir}" do
  not_if "test -d #{git_cache_dir}/refs"
  only_if "test -d /home/vagrant/opscode-monitoring/ubuntu-1204_git_cache"
end

execute "bundle install --binstubs" do
  cwd node['omnibus']['build_dir']
end

execute "bin/omnibus build #{node['omnibus']['project']}" do
  cwd node['omnibus']['build_dir']
end
