require 'spec_helper_acceptance'

describe 'auditd classes' do

  context 'server' do
    it 'should work idempotently with no errors' do
      if fact('osfamily') == 'RedHat'
        apply_manifest('class {"epel": }', :catch_failures => true)
      end

      pp = <<-EOS
      class { 'lynis': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('lynis') do
      it { is_expected.to be_installed }
    end

  end # server

end
