node.set[:bird][:name] = "bird"
node.set[:bird][:version] = 1.4.0
#node.set[:bird][:prefix] = "/usr"
#node.set[:bird][:binary][:url] = "ftp://bird.network.cz/pub/bird/#{node.bird.name}-#{node.bird.version}.tar.gz"

#providers:
#filter_net
#filter_protocol
#bgp
#ospf
#kernel_dev
#device_dev
#static_dev
#direct_dev


if node[:platform] == 'ubuntu'

  package "ncurses-dev" do
    action :install
  end

  package "bird" do
    action :install
  end

  directory node.bird.include_dir do
    owner "root"
    group "root"
    mode "0755"
    action :create
  end

  template "/etc/init.d/bird" do
    source "bird.init.erb"
    owner "root"
    group "root"
    mode "0644"
  end
  
  service "bird" do
    supports :restart => true, :status => false, :reload => false
    action [:enable, :start]
  end
end
