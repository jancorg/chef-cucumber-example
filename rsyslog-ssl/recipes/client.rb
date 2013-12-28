#
# Cookbook Name:: rsyslog-ssl
# Recipe:: rsyslog-ssl::client
#
# Copyright 2013, jancorg @ gmail.com
#

include_recipe 'rsyslog::client'
include_recipe 'rsyslog-ssl::default'

template '/etc/rsyslog.d/' + node['rsyslog']['ssl_client_conf'] do
  source 'rsyslog-' + node['rsyslog']['ssl_client_conf'] + '.erb'
  backup false
  variables(
    :stream_driver => node['rsyslog']['stream_driver'],
    :stream_driver_CAFile => node['rsyslog']['stream_driver_CAFile'],
    :stream_driver_mode => node['rsyslog']['stream_driver_mode'],
    :stream_driver_authMode => node['rsyslog']['stream_driver_authMode']
  )
  mode 0644
  owner node['rsyslog']['user']
  group node['rsyslog']['group']
  notifies :restart, 'service[' + node['rsyslog']['service_name'] + ']'
  action :create
  only_if { node['rsyslog']['use_SSL'] }
end



