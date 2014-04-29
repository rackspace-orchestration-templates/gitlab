site :opscode

cookbook 'build-essential'
cookbook 'apt'
cookbook 'mysql', '= 4.0.14'
cookbook 'nginx', '= 2.0.8'
cookbook 'gitlab',
  :git => 'https://github.com/atomic-penguin/cookbook-gitlab.git'

metadata

group :integration do
  cookbook 'apt', '~> 2.0'
end
