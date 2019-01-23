group 'telize'

user 'telize' do
  system true
  gid 'telize'
  shell '/sbin/nologin'
end

git '/srv/telize' do
  repository 'git://github.com/fcambus/telize.git'
  revision 'master'
end

bash 'fix permissions' do
  code 'chown -R telize:telize /srv/telize'
end
