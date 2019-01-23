kore_version = node['telize']['kore_version']

remote_file '/tmp/kore-tarball.tar.gz.minisig' do
  source "https://kore.io/releases/kore-#{kore_version}.tar.gz.minisig"
end

remote_file '/tmp/kore-tarball.tar.gz' do
  source "https://kore.io/releases/kore-#{kore_version}.tar.gz"
  verify 'minisign -Vm %{path} -P RWSxkEDc2y+whfKTmvhqs/YaFmEwblmvar7l6RXMjnu6o9tZW3LC0Hc9 -x /tmp/kore-tarball.tar.gz.minisig'
end

tar_extract '/tmp/kore-tarball.tar.gz' do
  action :extract_local
  target_dir '/tmp'
  creates "/tmp/kore-#{kore_version}"
end

bash 'install kore' do
  code 'make && make install'
  cwd "/tmp/kore-#{kore_version}"
  environment 'NOTLS' => '1'
end
