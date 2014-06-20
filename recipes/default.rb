#
# Cookbook Name:: telize
# Recipe:: default
# Installs telize geolocation service powered by nginx
# See telize documentation: https://github.com/M6Web/telize
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

# Install nginx-extras: nginx plus the modules we need (and more modules)
# Note this might only work on Debian-family systems
package 'nginx-extras' do
    action :install
end

# Install lua cjson module
include_recipe 'telize::lua_cjson'

# GeoIP databases
include_recipe 'telize::update_geoip_dbs'

# Pull in any updates from the https://github.com/M6Web/telize repo
include_recipe 'telize::git_update'

# Add nginx config files.
# Note original telize instructions update core nginx.conf, but a better practice is
# to put separate files in conf.d.  All files in /etc/nginx/conf.d are included by nginx.conf.
geoip_config_filename = if node['telize']['ipv6?']
                        then 'nginx-geoip-dbs-ipv6.conf'
                        else 'nginx-geoip-dbs.conf'
                        end
cookbook_file '/etc/nginx/conf.d/http_geoip.conf' do
    source geoip_config_filename
    mode '0644'
end

cookbook_file '/etc/nginx/conf.d/load_timezones.conf' do
    source 'nginx-include-timezones.conf'
    mode '0644'
end

# Enable the telize virtual server in nginx, and disable the 'default' virtal server
link '/etc/nginx/sites-enabled/telize' do
    to '/etc/nginx/sites-available/telize_x-forwarded-for'
    link_type :symbolic
    action :create
end

link '/etc/nginx/sites-enabled/default' do
    action :delete
end

# Enable reading of clients' IPs from whatever subnet our LB belongs to
bash 'configure_nginx_realip' do
    lb_subnet = node['telize']['lb_subnet']
    # we use sed to do this string replacement to avoid forking the upstream codebase. 
    code <<-EOH
        sed -i 's%set_real_ip_from 10.0.0.0/8; # Put your LB network here%set_real_ip_from #{lb_subnet};%' /etc/nginx/sites-available/telize_x-forwarded-for
        EOH
end

# Start the nginx service
service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
end
