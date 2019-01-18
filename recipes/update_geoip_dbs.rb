directory_path = '/var/db/GeoIP'

directory directory_path do
  recursive true
end

tar_extract 'https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz' do
  target_dir '/tmp'
  compress_char 'z'
end

tar_extract 'https://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN.tar.gz' do
  target_dir '/tmp'
  compress_char 'z'
end

bash 'copy files to where telize expects them to be' do
  code <<~CODE
  cp /tmp/GeoLite2-City_*/GeoLite2-City.mmdb #{directory_path}/
  cp /tmp/GeoLite2-ASN_*/GeoLite2-ASN.mmdb #{directory_path}/
  CODE
end
