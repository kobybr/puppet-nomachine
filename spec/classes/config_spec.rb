require 'spec_helper'

describe 'nomachine::terminalserver::config' do
  let(:params) do
    {
      package_ensure: package_ensure,
      base_path: '/usr/NX',
      server_config: server_config,
      node_config: node_config,
      server_license_content: server_license,
      node_license_content: node_license,
    }
  end

  let(:package_ensure) { 'present' }
  let(:server_config) { {} }
  let(:node_config) { {} }
  let(:server_license) { nil }
  let(:node_license) { nil }

  it { is_expected.to compile }

  context 'with licenses' do
    let(:server_license) { 'SERVERLICENSE' }
    let(:node_license) { 'NODELICENSE' }

    it do
      is_expected.to contain_file('/usr/NX/etc/server.lic').with(
        content: 'SERVERLICENSE',
      )
    end

    it do
      is_expected.to contain_file('/usr/NX/etc/node.lic').with(
        content: 'NODELICENSE',
      )
    end
  end

  context 'with server config' do
    let(:server_config) do
      {
        'Foo' => 'Bar',
      }
    end

    it do
      is_expected.to contain_augeas('server_config/Foo').with(
        incl: '/usr/NX/etc/server.cfg',
        changes: "set Foo 'Bar'",
      )
    end
  end

  context 'with node config' do
    let(:node_config) do
      {
        'Baz' => 'Qux',
      }
    end

    it do
      is_expected.to contain_augeas('node_config/Baz').with(
        incl: '/usr/NX/etc/node.cfg',
        changes: "set Baz 'Qux'",
      )
    end
  end

  context 'when package absent' do
    let(:package_ensure) { 'absent' }
    let(:server_config) { { 'Foo' => 'Bar' } }

    it { is_expected.not_to contain_augeas('server_config/Foo') }
  end
end
