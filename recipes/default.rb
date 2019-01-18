#
# Cookbook Name:: telize
# Recipe:: default
# Installs telize geolocation service powered by nginx
# See telize documentation: https://github.com/M6Web/telize
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe 'telize::install_kore'
include_recipe 'telize::libmaxmind'
include_recipe 'telize::install_telize'
include_recipe 'telize::update_geoip_dbs'
include_recipe 'telize::kore_server'
