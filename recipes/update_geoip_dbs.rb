directory_path = '/var/db/GeoIP'

directory directory_path do
  recursive true
end

tar_extract 'https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz' do
  target_dir directory_path
  compress_char 'z'
end

tar_extract 'https://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN.tar.gz' do
  target_dir directory_path
  compress_char 'z'
end
