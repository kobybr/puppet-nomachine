require 'spec_helper'

describe 'nomachine::terminalserver::service' do
  let(:params) do
    {
      package_ensure: package_ensure,
      service_ensure: 'running',
      service_enable: true,
    }
  end

  context 'when installed' do
    let(:package_ensure) { 'present' }

    it { is_expected.to compile }

    it do
      is_expected.to contain_service('nxserver').with(
        ensure: 'running',
        enable: true,
      )
    end
  end

  context 'when absent' do
    let(:package_ensure) { 'absent' }

    it do
      is_expected.to contain_service('nxserver').with(
        ensure: 'stopped',
        enable: false,
      )
    end
  end
end
