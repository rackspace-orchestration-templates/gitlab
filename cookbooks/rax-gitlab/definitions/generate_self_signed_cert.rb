define :generate_self_signed_cert do
  bash "Generating self signed certificate for #{node['fqdn']}" do
	user 'root'
	code <<-EOS
    mkdir -p -m 0700 #{File.dirname(node['gitlab']['ssl_certificate_key'])} 2> /dev/null
    mkdir -p #{File.dirname(node['gitlab']['ssl_certificate'])} 2> /dev/null
    openssl req \
    -x509 -nodes -days 730 \
    -subj '/CN='#{node['fqdn']}'/O=Place Holder/C=US/ST=Texas/L=San Antonio' \
    -newkey rsa:4096 -keyout #{node['gitlab']['ssl_certificate_key']} \
    -out #{node['gitlab']['ssl_certificate']}
	EOS
  end
end
