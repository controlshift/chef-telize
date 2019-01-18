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

directory '/srv/telize/dev' do
  owner 'telize'
  group 'telize'
end

bash 'set up random' do
  code <<~CODE
  /bin/mknod -m 0666 /srv/telize/dev/random c 1 8
  /bin/mknod -m 0666 /srv/telize/dev/urandom c 1 9
  chown telize:telize /srv/telize/dev/random /srv/telize/dev/urandom
  CODE
end
