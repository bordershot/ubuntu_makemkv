#
# Cookbook Name:: ubuntu_makemkv
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'build-essential'
package 'pkg-config'
package 'libc6-dev' 
package 'libssl-dev'
package 'libexpat1-dev'
package 'libavcodec-dev'
package 'libgl1-mesa-dev'
package 'libqt4-dev'

bin_file_name = "makemkv-bin-#{node['makemkv']['version']}.tar.gz"
oss_file_name = "makemkv-oss-#{node['makemkv']['version']}.tar.gz"

tar_package "http://www.makemkv.com/download/#{oss_file_name}"
tar_extract "http://www.makemkv.com/download/#{bin_file_name}" do
  target_dir '/tmp'
end

bash 'make_mkv_bin' do
  user 'root'
  cwd "/tmp/makemkv-bin-#{node['makemkv']['version']}"
  code <<-EOH
    mkdir -p tmp
    echo accepted > tmp/eula_accepted
    #make && make install
    make install
  EOH
#  action :nothing
end

