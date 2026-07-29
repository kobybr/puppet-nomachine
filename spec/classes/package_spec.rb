require 'spec_helper'

describe 'nomachine::terminalserver::package' do
  let(:params) do
    {
      base_package: 'nomachine-terminal-server',
      dependency_packages: ['foo', 'bar'],
      package_ensure: package_ensure,
    }
  end

  context 'with package present' do
    let(:package_ensure) { 'present' }

    it { is_expected.to compile }

    it do
      is_expected.to contain_package('nomachine-terminal-server').with(
        ensure: 'present',
      )
    end

    it { is_expected.to contain_package('foo') }
    it { is_expected.to contain_package('bar') }
  end

  context 'with latest' do
    let(:package_ensure) { 'latest' }

    it do
      is_expected.to contain_package('nomachine-terminal-server').with(
        ensure: 'latest',
      )
    end
  end

  context 'with pinned version' do
    let(:package_ensure) { '8.16.1-1' }

    it do
      is_expected.to contain_package('nomachine-terminal-server').with(
        ensure: '8.16.1-1',
      )
    end
  end

  context 'when absent' do
    let(:package_ensure) { 'absent' }

    it do
      is_expected.to contain_package('nomachine-terminal-server').with(
        ensure: 'absent',
      )
    end
  end
end
