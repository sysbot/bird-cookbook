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
  file_path = "#{node[:bird][:include_dir]}/#{new_resource.name}"
  Chef::Log.info "Adding #{new_resource.name.to_s}: acl to #{file_path}"

  # acls
  template "#{node[:bird][:include_dir]}/#{new_resource.name}.conf" do
    cookbook "bird"
    source "net_filter.erb"
    mode 00644
    owner "root"
    group "root"
    variables(
      :name => new_resource.name,
    	:acls => new_resource.acls
    )
    notifies :run, "execute[rebuild-bird]", :delayed
  end
end

action :remove do
  file_path = "#{node[:bird][:include_dir]}/#{new_resource.name}"
  if ::File.exists?(file_path)
    Chef::Log.info "Removing #{new_resource.file_type.to_s}: acl from #{file_path}"
    file zone_path do
      action :delete
    end
    new_resource.updated_by_last_action(true)
  end
end
