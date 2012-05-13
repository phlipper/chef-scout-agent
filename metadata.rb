name             "scout-agent"
maintainer       "Phil Cohen"
maintainer_email "github@phlippers.net"
license          "MIT"
description      "Setup Scount Server Monitoring Agent"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.0.0"

recipe "scout-agent", "Install and configure scout-agent"

depends "rvm"  # https://github.com/fnichol/chef-rvm

%w[ubuntu debian redhat centos fedora scientific amazon].each do |os|
  supports os
end
