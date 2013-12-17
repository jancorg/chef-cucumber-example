#
# Cookbook Name:: webpage
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#


include_recipe "apt"
package 'apache2'



service 'apache2' do
  action [:enable, :start]
end


cookbook_file '/var/www/index.html' do
  source 'webpage.html'
  owner "www-data"
  group "www-data"
end

