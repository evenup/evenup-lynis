require 'spec_helper'

describe 'lynis', :type => :class do

  it { should create_class('lynis::install') }
  it { should contain_package('lynis').with(:ensure => 'latest') }
  it { should contain_file('/usr/local/bin/lynis_parse.rb').with(:source => 'puppet:///modules/lynis/lynis_parse.rb') }

  context 'custom version' do
    let(:params) { { :version => '1.2.3' } }

    it { should contain_package('lynis').with(:ensure => '1.2.3') }
  end

end

