require 'spec_helper'

describe 'nomachine::terminalserver' do
  let(:params) do
    {
      package_ensure: 'present',
      base_package: 'nomachine-terminal-server',
      base_path: '/usr/NX',
      service_ensure: 'running',
      service_enable: true,
    }
  end

  it { is_expected.to compile.with_all_deps }

  it { is_expected.to contain_class('nomachine::terminalserver::package') }
  it { is_expected.to contain_class('nomachine::terminalserver::config') }
  it { is_expected.to contain_class('nomachine::terminalserver::service') }

  it do
    is_expected.to contain_class('nomachine::terminalserver::package')
      .that_comes_before('Class[nomachine::terminalserver::config]')
  end

  it do
    is_expected.to contain_class('nomachine::terminalserver::config')
      .that_comes_before('Class[nomachine::terminalserver::service]')
  end
end
