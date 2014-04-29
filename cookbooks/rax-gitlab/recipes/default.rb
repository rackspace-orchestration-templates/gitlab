include_recipe 'apt'
include_recipe 'build-essential'

include_recipe 'mysql::server'

if node['gitlab']['generate_self_signed_cert']
  if !File.exists?(node['gitlab']['ssl_certificate']) && !File.exists?(node['gitlab']['ssl_certificate_key'])
    generate_self_signed_cert
  end
end

node.set[:gitlab][:git_branch] = 'v6.7.3'

include_recipe 'gitlab::default'
include_recipe 'gitlab::mysql'

gitlab_user_file = '/root/.gitlab.user.initialized'
unless File.exists?(gitlab_user_file)

  template node['gitlab']['app_home'] + '/user.rb' do
    owner node['gitlab']['user']
    group node['gitlab']['group']
    mode '0600'
    source 'user.rb.erb'
    variables(
      username: node['gitlab']['admin_user'],
      password: node['gitlab']['admin_password']
    )
  end

  execute "Set Admin user Credentials" do
    user node['gitlab']['user']
    group node['gitlab']['group']
    cwd node['gitlab']['app_home']
    environment('LANG' => 'en_US.UTF-8', 'LC_ALL' => 'en_US.UTF-8')
    command <<-EOS
    ./bin/rails console production < user.rb
    rm -f user.rb
    EOS
    action :run
  end

  execute "Touch User Initialized File" do
    user 'root'
    group 'root'
    command "touch #{gitlab_user_file}"
    action :run
  end
end
