require 'spec_helper'

describe 'nomachine::terminalserver' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('nomachine::terminalserver::config') }
        it { is_expected.to contain_class('nomachine::terminalserver::service') }
        it { is_expected.to contain_class('nomachine::terminalserver::package') }
      end
    end
  end
end
