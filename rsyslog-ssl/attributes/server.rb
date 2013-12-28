override['rsyslog']['ssl_server_conf'] = '45-ssl-server.conf'
override['rsyslog']['stream_driver_cert_file'] = node[
  'rsyslog']['stream_driver_keyDir'] + '/server.crt'
override['rsyslog']['stream_driver_key_file'] = node[
  'rsyslog']['stream_driver_keyDir'] + '/server.key'
