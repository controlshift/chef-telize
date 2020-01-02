directory_path = '/srv/telize/var/db/GeoIP'

directory directory_path do
  recursive true
end

apt_package 'geoipupdate' do
  notifies :create, 'template[/usr/local/etc/GeoIP.conf]', :immediately
end

template '/usr/local/etc/GeoIP.conf' do
  source 'GeoIP.conf.erb'
  variables({
              account_id: account_id,
              license_key: license_key,
              edition_ids: edition_ids,
              directory_path: directory_path
            })

  action :nothing
  notifies :run, 'bash[geoipupdate]', :immediately
end

bash 'geoipupdate' do
  code <<~CODE
  /usr/local/bin/geoipupdate
  CODE

  action :nothing
end

# TODO: set up a cron job to run geoipupdate weekly

#tar_extract 'https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz' do
#  target_dir '/tmp'
#  compress_char 'z'
#end
#
#tar_extract 'https://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN.tar.gz' do
#  target_dir '/tmp'
#  compress_char 'z'
#end
#
#bash 'copy files to where telize expects them to be' do
#  code <<~CODE
#  cp /tmp/GeoLite2-City_*/GeoLite2-City.mmdb #{directory_path}/
#  cp /tmp/GeoLite2-ASN_*/GeoLite2-ASN.mmdb #{directory_path}/
#  chown -R telize:telize #{directory_path}
#  CODE
#end
