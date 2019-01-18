user_account 'telize' do
  create_group true
  shell '/bin/bash'
end

remote_file '/tmp/kore-tarball.tar.gz' do
  source 'https://kore.io/releases/kore-3.2.1.tar.gz'
  #verify 'minisign -Vm %{path} -P RWSxkEDc2y+whfKTmvhqs/YaFmEwblmvar7l6RXMjnu6o9tZW3LC0Hc9'
end

tar_extract '/tmp/kore-tarball.tar.gz' do
  action :extract_local
  target_dir '/tmp'
  creates '/tmp/kore-3.2.1'
end

bash 'install kore' do
  code 'make && make install'
  cwd '/tmp/kore-3.2.1'
end
