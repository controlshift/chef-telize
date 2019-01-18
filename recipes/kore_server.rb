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
  SyslogIdentitifer=kore
  User=telize
  Group=telize

  [Install]
  WantedBy=multi-user.target
  CONTENT

  action [:create, :enable]
end
