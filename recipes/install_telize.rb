group 'telize'

user 'telize' do
  system true
  gid 'telize'
  shell '/sbin/nologin'
end

git '/srv/telize' do
  repository 'https://github.com/fcambus/telize.git'
  revision '3.1.1'
end

bash 'fix permissions' do
  code 'chown -R telize:telize /srv/telize'
end
