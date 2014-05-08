#!/usr/bin/env ruby

class Bird
  DIR = "<%= node[:bird][:directory] %>"

  def initialize
    generate_acl_includes
    generate_key_includes
    generate_view_includes
  end

  def generate_acl_includes
    view_includes = "#{DIR}/acl_includes.conf"
    create_includes_from_folder(view_includes, "#{DIR}/acl.d")
  end

  def generate_ospf_includes
    ospf_includes = "#{DIR}/ospf_includes.conf"
    create_includes_from_folder(ospf_includes, "#{DIR}/ospf.d")
  end

  def generate_bgp_includes
    bgp_includes = "#{DIR}/bgp_includes.conf"
    create_includes_from_folder(bgp_includes, "#{DIR}/bgp.d")
  end

  def create_includes_from_folder(target, folder)
    includes = Dir.glob("#{folder}/*.conf").map! { |x|
      x = "include \"#{x.sub(DIR, '')}\";"
      }
    File.open(target, "w") { |f| f.write(includes.sort.join("\n")) }
  end
end

Bird.new