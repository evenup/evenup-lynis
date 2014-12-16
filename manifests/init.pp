# == Class: lynis
#
# This class installs and configures lynis (http://rootkit.nl/projects/lynis.html)
#
#
# === Parameters
#
# [*version*]
#   String.  What version of lynis should be installed
#   Default: latest
#
#
# === Examples
#
# * Installation:
#     class { 'lynis': }
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

class lynis (
  $version = 'latest',
) {

  class { 'lynis::install': }

}
