name             "gitlab-http-redirect"
maintainer       "Rackspace"
maintainer_email "checkmate@lists.rackspace.com"
license          "Apache 2.0"
description      "nginx redirect"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
recipe           "gitlab-http-redirect", "Sets 80->443 redirect"

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end

%w{ firewall nginx iptables-ng }.each do |cb|
  depends cb
end
