require 'spec_helper'

# se deberia controlar que los templates estan como queremos



describe service('rsyslog') do
  it { should be_running }
end


now = Time.new.to_i.to_s

describe file('/var/log/syslog') do
  before do
    `logger -t integration_test #{now}`
  end
  it { should contain "#{now}" }
end
