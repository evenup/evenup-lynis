# == Definition: lynis::profile
#
# This define sets up a specific lynis profile with optional cron entry and formatting for logstash
#
# === Parameters
#
# [*source*]
#   String.  The source file for the profile
#
# [*profile_name*]
#   String.  Name to be used for the profile
#
# [*enable_cron*]
#   Boolean.  Configure a cron script to run the profile
#   Default: false
#
# [*hour*]
#   Integer.  Hour of the day to run the cron job
#   Default: fqdn_rand(23)
#
# [*minute*]
#   Integer.  Minute of the day to run the cron job
#   Default: fqdn_rand(59)
#
# [*logstashify*]
#   Boolean.  If the resulting lynis-report.dat should be converted to JSON and appended to a long
#     file for import into logstash (complete with require LS fields)
#
# === Examples
#
#   lynis::profile { 'supersecure': }
#     source        => 'puppet:///data/supersecure.prf',
#     profile_name  => 'hack_this',
#     enable_cron   => true,
#     logstashify   => true,
#   }
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
define lynis::profile (
  $source,
  $profile_name,
  $enable_cron  = false,
  $hour         = fqdn_rand(23),
  $minute       = fqdn_rand(59),
  $logstashify  = false,
) {

  file { "/etc/lynis/${profile_name}.prf":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => $source,
  }

  if $logstashify {
    $ls = ' && /usr/local/bin/lynis_parse.rb'
  } else {
    $ls = ''
  }

  if $enable_cron {
    cron { $profile_name:
      ensure  => 'present',
      command => "/usr/bin/lynis --cronjob --profile /etc/lynis/${profile_name}.prf${ls}",
      hour    => $hour,
      minute  => $minute,
    }
  } else {
    cron { $profile_name: ensure  => 'absent' }
  }

}
