#
# Cookbook Name:: rsyslog-ssl
# Recipe:: default
#
# Copyright 2013, JAC
#
# All rights reserved - Do Not Redistribute
#
# Sustituye rsyslog:client para nuestra arquitectura (rsyslog -> logserver -> proceso)

include_recipe 'apt' # if not ::File.exists?('/var/lib/apt/periodic/update-success-stamp')
include_recipe 'rsyslog'


package 'rsyslog-gnutls' do
  version node['rsyslog']['gtls_version']
  action :install
  not_if do ::File.exists?('/usr/lib/rsyslog/lmnsd_gtls.so') end
end

directory node['rsyslog']['stream_driver_keyDir'] do
  action :create
  owner node['rsyslog']['user']
  group node['rsyslog']['group']
  mode node['rsyslog']['keyDirMode']
  recursive   true
  only_if { node['rsyslog']['use_SSL'] }
end
# coger de una databag
cookbook_file node['rsyslog']['stream_driver_CAFile'] do
  owner node['rsyslog']['user']
  group node['rsyslog']['group']
  mode node['rsyslog']['stream_driver_CAFileMode']
  notifies :reload, 'service[' +  node['rsyslog']['service_name'] + ']'
  action :create
  only_if { node['rsyslog']['use_SSL'] }
end

file '/etc/rsyslog.d/20-ufw.conf' do
  action   :delete
  notifies :reload, 'service[' + node['rsyslog']['service_name'] + ']'
  only_if { ::File.exists?('/etc/rsyslog.d/20-ufw.conf') }
end


ruby_block 'rename remote' do
  block do
    ::File.rename('/etc/rsyslog.d/49-remote.conf',
      '/etc/rsyslog.d/42-remote.conf')
  end
  only_if { ::File.exists?('/etc/rsyslog.d/49-remote.conf') }
end

file '/etc/rsyslog.conf' do
  action   :delete
end

template '/etc/rsyslog.conf' do
  source  'rsyslog.conf.erb'
  owner   'root'
  group   'root'
  mode    '0644'
  notifies :reload, 'service[' + node['rsyslog']['service_name'] + ']'
end

