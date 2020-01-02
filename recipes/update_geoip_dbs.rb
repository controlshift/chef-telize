directory_path = '/srv/telize/var/db/GeoIP'

directory directory_path do
  owner 'telize'
  group 'telize'
  recursive true
end

apt_package 'geoipupdate'

# TODO: Figure out if the EditionIDs are all needed, or can we skip some?
template '/usr/local/etc/GeoIP.conf' do
  source 'GeoIP.conf.erb'
  variables({ directory_path: directory_path })
end

cron 'run geoipupdate' do
  # Run once a week, on Sunday morning at 4AM UTC
  weekday '0'
  hour '4'
  minute '0'
  #shell '/bin/bash'
  #path '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
  command '/usr/local/bin/geoipupdate'
end
