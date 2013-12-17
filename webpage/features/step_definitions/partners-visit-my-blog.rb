require 'leibniz'
require 'faraday'


Given(/^I have provisioned the following infrastructure:$/) do |table|
  @infrastructure = Leibniz.build(table)
end

Given(/^I have run Chef$/) do
  @infrastructure.destroy
  @infrastructure.converge
end

Given(/^a url "(.*?)"$/) do |url|
#Given(/^a url http:\/\/simpleweb\.local$/) do
  @host_header = url.split('/').last
  @url = url
end

When(/^a web user browses to the URL$/) do 
#  connection = Faraday.new(:url => "http://#{@infrastructure['simpleweb'].ip}",
   connection = Faraday.new(:url => @url,
                           :headers => {'Host' => @host_header}) do |faraday|
    faraday.adapter Faraday.default_adapter
  end
  @page = connection.get('/').body
end

Then(/^the user should see "(.*?)"$/) do |content|
  expect(@page).to match /#{content}/
end
