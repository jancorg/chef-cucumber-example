require 'chefspec'

describe 'rsyslog-ssl::default' do

  let (:chef_run) {
    Chef::Recipe.
      any_instance.stub(:search).
      with(:node, 'role:loghost AND chef_environment:example').
      and_yield({ 'hostname' => 'rsyslog1.example.com' })
    Chef::Recipe.any_instance.stub(:search).with(:node, 'role:loghost').
      and_yield({ 'hostname' => 'rsyslog1.example.com' })

    chef_run = ChefSpec::ChefRunner.new do |node|
      node.set['rsyslog']['ssl_client_conf'] = '45-ssl-client.conf'
      node.set['rsyslog']['user'] = 'syslog'
      node.set['rsyslog']['group'] = 'adm'
      node.set['rsyslog']['stream_driver_keyDir'] = '/etc/rsyslog.d/keys'
      node.set['rsyslog']['stream_driver_CAFile'] = node[
        :rsyslog][:stream_driver_keyDir] + '/ca.crt'

      @node = node
    end
    chef_run.converge 'rsyslog-ssl::default'
  }


  it 'should include apt recipe' do
    chef_run.should include_recipe 'apt'
  end

  it 'should include rsyslog recipe' do
    chef_run.should include_recipe 'rsyslog'
  end

  it 'should installs rsyslog-gnutls package' do
    chef_run.should install_package 'rsyslog-gnutls'
  end

end
