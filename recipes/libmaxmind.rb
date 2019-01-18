apt_repository 'maxmind' do
  uri 'ppa:maxmind/ppa'
end

apt_update 'update package info' do
  action :update
end

apt_package 'libmaxminddb0'
apt_package 'libmaxminddb-dev'
apt_package 'mmdb-bin'
