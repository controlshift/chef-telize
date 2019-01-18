bash 'build server' do
  code 'kodev build'
  cwd '/srv/telize'
end

systemd_unit 'kore.service' do
  context <<~CONTENT
  [Unit]
  Description=Kore web server
  Requires=network.target
  After=syslog.target network.target

  [Service]
  Type=simple
  WorkingDirectory=/srv/telize
  ExecStart=/bin/bash -lc 'kore'

  [Install]
  WantedBy=multi-user.target
  CONTENT

  action [:create, :enable]
end
