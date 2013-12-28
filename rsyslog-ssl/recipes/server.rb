#
# Cookbook Name:: system-configuration
# Recipe:: rsyslog-ssl::server
#
# Copyright 2013, jancorg @ gmail.com
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'rsyslog-ssl::default'
include_recipe 'rsyslog::server'


[ node['rsyslog']['stream_driver_cert_file'], node['rsyslog']['stream_driver_key_file'] ].each do |file|
  cookbook_file file do
    owner node['rsyslog']['user']
    group node['rsyslog']['group']
    mode node['rsyslog']['stream_driver_CAFileMode']
    notifies :reload, 'service[' + node['rsyslog']['service_name'] + ']'
    action :create
    only_if { node['rsyslog']['use_SSL'] }
  end
end

template '/etc/rsyslog.d/' +  node['rsyslog']['ssl_server_conf'] do
  source 'rsyslog-' + node['rsyslog']['ssl_server_conf'] + '.erb'
  backup false
  variables(
    :stream_driver => node['rsyslog']['stream_driver'],
    :stream_driver_CAFile => node['rsyslog']['stream_driver_CAFile'],
    :stream_driver_mode => node['rsyslog']['stream_driver_mode'],
    :stream_driver_cert_file => node['rsyslog']['stream_driver_cert_file'],
    :stream_driver_key_file => node['rsyslog']['stream_driver_key_file'],
    :stream_driver_authMode => node['rsyslog']['stream_driver_authMode'],
    :server_port => node['rsyslog']['port']
  )
  mode 0644
  owner node['rsyslog']['user']
  group node['rsyslog']['group']
  notifies :restart, 'service[' + node['rsyslog']['service_name'] + ']'
  action :create
  only_if { node['rsyslog']['use_SSL'] }
end

file '/etc/rsyslog.d/49-remote.conf' do
  action   :delete
  notifies :reload, 'service[' + node['rsyslog']['service_name'] + ']'
  only_if { ::File.exists?('/etc/rsyslog.d/49-remote.conf') }
end

