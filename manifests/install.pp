# == Class: lynis::install
#
# This class installs lynis.  It should not be directly called.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
# === Copyright
#
# Copyright 2014 EvenUp.
#
class lynis::install {

  package { 'lynis':
    ensure  => $::lynis::version
  }

  file { '/usr/local/bin/lynis_parse.rb':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0555',
    source => "puppet:///modules/${module_name}/lynis_parse.rb"
  }
}
