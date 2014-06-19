#
# Cookbook Name:: telize
# Recipe:: git_update
# Pull in any updates from the https://github.com/M6Web/telize repo
#

package 'git' do
    action :install
end

checkout_location = File.join(Chef::Config['file_cache_path'], 'telize')

# Sync our clone
git checkout_location do
    repository 'https://github.com/M6Web/telize.git'
    action :sync
end

# Tell chef where to put the files that come from the git repo
file_to_destination = {'telize' => '/etc/nginx/sites-available',
                       'timezone.conf' => '/etc/nginx'}

file_to_destination.each do |filename, destination|
    file File.join(destination, filename) do
        mode '0644'
        content lazy { IO.read(File.join(checkout_location, filename)) }
        action :create
    end
end
