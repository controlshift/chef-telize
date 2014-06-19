#
# Cookbook Name:: telize
# Recipe:: lua_cjson
# Installs the Lua CJSON module
#
package 'luarocks' do
    action :install
end

bash 'install_lua_cjson' do
    code <<-EOH
        luarocks install lua-cjson
        EOH
end
