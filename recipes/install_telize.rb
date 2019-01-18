git '/srv/telize' do
  repository 'git://github.com/fcambus/telize.git'
  revision 'master'
  user 'telize'
  group 'telize'
end

cookbook_file '/srv/telize/telize.config' do
  source 'telize.config'
  owner 'telize'
  group 'telize'
  mode '0644'
  action :create
end
