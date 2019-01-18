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
  Type=simple
  WorkingDirectory=/srv/telize
  ExecStart=/bin/bash -lc 'kore -c telize.config'
  StandardOutput=syslog
  StandardError=syslog
  SyslogIdentitifer=kore

  [Install]
  WantedBy=multi-user.target
  CONTENT

  action [:create, :enable]
end
