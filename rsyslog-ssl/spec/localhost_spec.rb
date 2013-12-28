require 'chefspec'

describe 'rsyslog-wrapper::default' do

  let (:chef_run) {

    chef_run = ChefSpec::ChefRunner.new do |node|
      node.set['rsyslog']['ssl_client_conf'] = '45-ssl-client.conf'
      node.set['rsyslog']['user'] = 'syslog'
      node.set['rsyslog']['group'] = 'adm'
      node.set['rsyslog']['stream_driver_keyDir'] = '/etc/rsyslog.d/keys'
      node.set['rsyslog']['stream_driver_CAFile'] = node[
        :rsyslog][:stream_driver_keyDir] + '/ca.crt'
    end
    chef_run.converge 'rsyslog-wrapper::localhost'
  }

  it 'should installs nmap package' do
    chef_run.should install_package 'nmap'
  end


end
