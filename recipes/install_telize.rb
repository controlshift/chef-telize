git '/srv/telize' do
  repository 'git://github.com/fcambus/telize.git'
  revision 'master'
end

directory '/srv/telize' do
  owner 'telize'
  group 'telize'
  recursive true
end

cookbook_file '/srv/telize/telize.config' do
  source 'telize.config'
  owner 'telize'
  group 'telize'
  mode '0644'
  action :create
end
