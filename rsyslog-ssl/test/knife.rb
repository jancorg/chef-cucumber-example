current_dir             = File.dirname(__FILE__)
cookbook_path           ["#{current_dir}/..", "#{current_dir}/cookbooks"]
cache_type 'BasicFile'
cache_options(:path => "#{ENV['HOME']}/.chef/checksums")
