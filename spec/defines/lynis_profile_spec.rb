require 'spec_helper'

describe 'lynis::profile', :type => :define do
  let(:title) { 'my_profile' }

  context 'source only' do
    let(:params) { { :profile_name => 'my_profile', :source => 'puppet:///data/my_profile.prf' } }

    it { should contain_file('/etc/lynis/my_profile.prf') }
    it { should contain_cron('my_profile').with(:ensure => 'absent') }
  end

  context 'with cron' do
    let(:params) { { :profile_name => 'my_profile', :source => 'puppet:///data/my_other_profile.prf', :enable_cron => true, :hour => 3, :minute => 10} }

    it { should contain_file('/etc/lynis/my_profile.prf') }
    it { should contain_cron('my_profile').with(
      :ensure   => 'present',
      :command  => '/usr/bin/lynis --cronjob --profile /etc/lynis/my_profile.prf > /dev/null',
      :hour     => 3,
      :minute   => 10
    ) }
  end

  context 'with logstashify' do
    let(:params) { { :profile_name => 'ls_profile', :source => 'puppet:///data/profile.prf', :enable_cron => true, :logstashify => true } }

    it { should contain_cron('ls_profile').with(
      :ensure   => 'present',
      :command  => '/usr/bin/lynis --cronjob --profile /etc/lynis/ls_profile.prf > /dev/null && /usr/local/bin/lynis_parse.rb'
    ) }
  end

end

