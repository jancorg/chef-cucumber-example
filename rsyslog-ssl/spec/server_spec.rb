require 'chefspec'

describe 'rsyslog-ssl::server' do
  let (:chef_run) {
    Chef::Recipe.
      any_instance.stub(:search).
      with(:node, 'role:loghost AND chef_environment:example').
      and_yield({ 'hostname' => 'rsyslog1.example.com' })
    Chef::Recipe.
      any_instance.stub(:search).
      with(:node, 'role:loghost').
      and_yield({ 'hostname' => 'rsyslog1.example.com' })

    chef_run = ChefSpec::ChefRunner.new do |node|
      node.set['rsyslog']['ssl_client_conf'] = '45-ssl-client.conf'
      node.set['rsyslog']['user'] = 'syslog'
      node.set['rsyslog']['group'] = 'adm'
      node.set['rsyslog']['stream_driver_keyDir'] = '/etc/rsyslog.d/keys'
      node.set['rsyslog']['stream_driver_CAFile'] = node[
        :rsyslog][:stream_driver_keyDir] + '/ca.crt'
    end
    chef_run.converge 'rsyslog-ssl::server'
  }

  it 'should include rsyslog::server recipe' do
    chef_run.should include_recipe 'rsyslog::server'
  end

  it 'should include rsyslog-ssl recipe' do
    chef_run.should include_recipe 'rsyslog-ssl::default'
  end


end

