require 'spec_helper'




describe command('nmap 10.33.33.11 -p 10514 | grep open') do
  before do
  	`apt-get install -y nmap`
  end
  it { should return_stdout '10514/tcp open  unknown' }
end


#describe command('openssl s_client -showcerts -connect 10.33.33.11:10514 -CAfile /etc/rsyslog.d/keys/ca.crt & export PID=$! ; sleep 1 && kill $PID') do
#  before do
#  	`#echo`
#  end
#  it { should return_stdout 'CONNECTED(00000003)' }
#end






describe command('') do
  it { should return_stdout '' }
end


