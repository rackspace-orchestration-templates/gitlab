#!/usr/bin/env ruby
#^syntax detection

site :opscode

cookbook 'iptables-ng'

cookbook 'build-essential',
  :git => 'https://github.com/opscode-cookbooks/build-essential.git'

cookbook 'mysql',
  :git => 'https://github.com/opscode-cookbooks/mysql.git',
  :ref => 'd9c657f8e84a3d517514f9e7f618ea279cb9b84d'

cookbook 'nginx', '= 2.0.8'

cookbook 'firewall',
  :git => 'https://github.com/opscode-cookbooks/firewall.git'

cookbook 'rax-gitlab',
  :git => 'https://github.com/JasonBoyles/rax-gitlab.git',
  :ref => '4b96b8b57d10cecf2c22a4b556a932f1e187f390'

cookbook 'postfix',
  :git => 'https://github.com/brint/postfix.git',
  :branch => 'no_overwrite'
