require 'leibniz'
require 'faraday'

Given(/^I have provisioned the following infrastructure:$/) do |table|
  @infrastructure = Leibniz.build(table)
end

Given(/^I have run Chef$/) do
  @infrastructure.destroy
  @infrastructure.converge
end

#/^a test user '(?<user>.*?)'$/
Given(/^a test user '(.*?)'$/) do |user|
  @username = user
  @username.nil?.should be_false
end

When(/^user logins via SSH$/) do
   # express the regexp above with the code you wish you had 10.2.3.12
# conectar con usuario a cliente
  ssh_command = 'ssh -i ~/.vagrant.d/insecure_private_key ' +
    @username + '@10.2.3.12 ' +
    '-o PasswordAuthentication=no ' +
    '-o StrictHostKeyChecking=no ' +
    '-o UserKnownHostsFile=/dev/null ' + 
    ' ls'
  `#{ssh_command}`
end

Then(/^remote log server should register login fail$/) do
  #10.2.3.11
  ssh_command = 'ssh -i ~/.vagrant.d/insecure_private_key vagrant@10.2.3.11 ' +
    '-o PasswordAuthentication=no -o StrictHostKeyChecking=no ' +
    '-o UserKnownHostsFile=/dev/null ' +
    "tail -20 /var/log/rsyslog/#{Time.now.strftime("%Y/%m/%d")}/leibniz-rsyslog-client/auth.log"
  output = `#{ssh_command}`
  output.include?('input_userauth_request: invalid user ' + @username).should be_true
end
