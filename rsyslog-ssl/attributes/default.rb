default['rsyslog']['keyDirMode'] = '0750'
default['rsyslog']['stream_driver'] = 'gtls'
default['rsyslog']['stream_driver_keyDir'] = '/etc/rsyslog.d/keys'
default['rsyslog']['stream_driver_CAFile'] = node[
  'rsyslog']['stream_driver_keyDir'] + '/ca.crt'

default['rsyslog']['stream_driver_CAFileMode'] = '0600'
default['rsyslog']['stream_driver_mode'] = '1'
default['rsyslog']['stream_driver_authMode'] = 'anon'
override['rsyslog']['gtls_version'] = '5.8.6-1ubuntu8.6'

override['rsyslog']['server_ip'] = '10.2.3.11'
override['rsyslog']['port'] = '10514'
override['rsyslog']['server_search'] = ''\
  'role:loghost AND chef_environment:example'

override['rsyslog']['log_dir'] = '/var/log/rsyslog'

override['rsyslog']['user'] = 'syslog'
override['rsyslog']['group'] = 'adm'

default['rsyslog']['use_SSL'] = true
