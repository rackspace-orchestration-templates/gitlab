#
# Cookbook Name:: gitlab-http-redirect
# Recipe:: default
#
# Copyright 2014, Rackspace
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

http_listen_port = node['gitlab']['listen_port'] || (node['gitlab']['https'] ? 80 : 443)
if node['gitlab']['https']
  template '/etc/nginx/sites-available/http_redirect' do
    owner 'root'
    group 'root'
    mode '0644'
    source 'nginx.redirect.erb'
    notifies :reload, 'service[nginx]', :delayed
    variables(
      listen: http_listen_port
    )
  end

  nginx_site 'http_redirect' do
    enable true
  end

  case node['platform_family']
  when 'debian'
    firewall_rule "Firewall rule, tcp/#{http_listen_port}" do
  	  port http_listen_port
  	  protocol :tcp
  	  direction :in
  	  action :allow
    end
  when 'rhel'
    iptables_ng_rule 'Firewall rule, tcp/#{http_listen_port}' do
      name       'GitLab'
      chain      'INPUT'
      table      'filter'
      ip_version [4, 6]
      rule       "-p tcp --dport #{http_listen_port} -j ACCEPT"
      action :create_if_missing
    end
  end
end
