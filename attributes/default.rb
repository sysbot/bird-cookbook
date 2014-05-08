default[:bird][:enabled] = true
default[:bird][:directory] = "/etc"
default[:bird][:include_dir] = "#{node.bird.directory}/bird.d"