# Provider:: filter
#
# Copyright 2014, Bao Nguyen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :add do
  zone_path = "#{[node[:bird][:directory]].join}/#{new_resource.name}"
  Chef::Log.info "Adding #{new_resource.name.to_s}: acl to #{zone_path}"

  # acl records
  template "/etc/bird.d/#{new_resource.name}.conf" do
    cookbook "bird"
    source "filter.erb"
    mode 00644
    owner "root"
    group "root"
    variables(
      :name => new_resource.name,
    	:filter => new_resource.filter
    )
    notifies :run, "execute[rebuild-bird]", :delayed
  end
end

action :remove do
  zone_path = "#{[node[:bird][:chroot], node[:bird][:directory]].join}/#{new_resource.name}"
  if ::File.exists?(zone_path)
    Chef::Log.info "Removing #{new_resource.file_type.to_s}: acl from #{zone_path}"
    file zone_path do
      action :delete
    end
    new_resource.updated_by_last_action(true)
  end
end

filter = {
	:device => {
		:net => 
	} "net",
	src_net: "abc",
	dst_dev: "net"
	dst_net: "abc",
	options: ["abc"],
	action: "reject"
}

