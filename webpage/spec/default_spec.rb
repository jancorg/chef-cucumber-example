require 'chefspec'

describe 'system-configuration::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'webpage::default' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
