cookbook_file '/srv/telize/telize.config' do
  source 'telize.config'
  owner 'telize'
  group 'telize'
  mode '0644'
  action :create
end

directory '/srv/telize/dev' do
  owner 'telize'
  group 'telize'
end

bash 'set up random' do
  code <<~CODE
  /bin/mknod -m 0666 /srv/telize/dev/urandom c 1 9
  chown telize:telize /srv/telize/dev/urandom
  CODE
end

bash 'build server' do
  code 'kodev build'
  cwd '/srv/telize'
end

# needed for ifconfig, which finish_core_config.sh uses
apt_package 'net-tools'

cookbook_file '/etc/finish_kore_config.sh' do
  source 'finish_kore_config.sh'
  mode '0755'
end

systemd_unit 'kore.service' do
  content <<~CONTENT
  [Unit]
  Description=Kore web server
  Requires=network.target
  After=syslog.target network.target

  [Service]
  Type=forking
  WorkingDirectory=/srv/telize
  ExecStart=/bin/bash -lc 'kore -c telize.config'
  StandardOutput=syslog
  StandardError=syslog
  SyslogIdentifier=kore

  [Install]
  WantedBy=multi-user.target
  CONTENT

  action [:create]
end
