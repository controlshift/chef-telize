apt_package 'libsodium-dev'
apt_package 'pkg-config'
apt_package 'cmake'

git '/tmp/minisign' do
  repository 'git://github.com/jedisct1/minisign.git'
  revision 'master'
end

bash 'install minisign' do
  code <<~CODE
  mkdir build
  cd build
  cmake ..
  make
  make install
  CODE
  cwd '/tmp/minisign'
  environment 'PKG_CONFIG_EXECUTABLE' => '/usr/bin/pkg-config'
end
