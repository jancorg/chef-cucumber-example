#
# Cookbook Name:: rsyslog-ssl
# Recipe:: rsyslog::localhost
#
# Copyright 2013, Finect Inc
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'apt' # if not ::File.exists?('/var/lib/apt/periodic/update-success-stamp')

package 'nmap' do
  action :install
  version '5.21-1ubuntu1'
end

package 'openssl' do
  action :install
  version '1.0.1-4ubuntu5.10'
end

[ node['rsyslog']['stream_driver_keyDir'], node['rsyslog']['stream_driver_CAFile'] ].each do |file|

  directory file do
    action :create
    owner node['rsyslog']['user']
    group node['rsyslog']['group']
    mode node['rsyslog']['keyDirMode']
    recursive   true
    only_if { node['rsyslog']['use_SSL'] }
  end
end