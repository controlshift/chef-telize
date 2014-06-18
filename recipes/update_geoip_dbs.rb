#
# Cookbook Name:: telize
# Recipe:: update_geoip_dbs
# Installs the latest version of the GeoIP databases.
#
destination_dir = '/usr/share/GeoIP/'
sources_by_file = {'GeoIPv6.dat' => 'http://geolite.maxmind.com/download/geoip/database/GeoIPv6.dat.gz',
                   'GeoLiteCityv6.dat' => 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCityv6-beta/GeoLiteCityv6.dat.gz',
                   'GeoIPASNumv6.dat' => 'http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNumv6.dat.gz'}
# In testing we sometimes get 403s from rate limiting on maxmind.
# One workaround is to use a simple server locally to serve the zipped versions of the files
# Uncomment the below and replace with the right IP address to use such an alternate server.
sources_by_file = {'GeoIPv6.dat' => 'http://192.168.0.237:8000/GeoIPv6.dat.gz',
                   'GeoLiteCityv6.dat' => 'http://192.168.0.237:8000/GeoLiteCityv6.dat.gz',
                   'GeoIPASNumv6.dat' => 'http://192.168.0.237:8000/GeoIPASNumv6.dat.gz'}

directory destination_dir do
    action :create
end

sources_by_file.each do |destination_filename, source_url|
    zipped_filename = destination_filename + '.gz'
    zipped_filepath = "#{Chef::Config['file_cache_path']}/#{zipped_filename}"

    # Retrieve the zipped DB, telling the server to only bother if it has changed since we last asked.
    # TODO: If the server is down, this will fail the whole recipe.  It would be nice to have a fallback
    # where if we have /any/ copy of the DB already (zipped, old, whatever), we use that and move on.
    remote_file zipped_filepath do
        source source_url
        use_conditional_get true
        use_last_modified true
    end

    # If we got a new zipped DB, unzip it to where we need it to be
    destination_filepath = File.join(destination_dir, destination_filename)
    bash 'extract_db' do
        cwd ::File.dirname(zipped_filepath)
        code <<-EOH
            gunzip -c #{zipped_filename} > #{destination_filepath}
            EOH
        only_if { not ::File.exists?(destination_filepath) or
                  ::File.mtime(destination_filepath) < ::File.mtime(zipped_filepath)}
    end
end
