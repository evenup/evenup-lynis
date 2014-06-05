What is it?
===========

A puppet module that installs lynis [rootkit.nl/projects/lynis.html] and allows you to configure
profiles with associated daily cron entries.  A script is provided as well that
converts converts the lynis-report.dat file to json, adds the @timestamp and
@version keys, and appends it to a file to be imported straight into logstash.

Usage:
------

Generic lynis install
<pre>
  class { 'lynis': }
</pre>

Adding a profile to be run manually
<pre>
  lynis::profile { 'my_profile':
    profile_name  => 'my_profile',
    source        => 'puppet:///data/lynis/my_profile.prf',
  }
</pre>

Adding a profile and using the random hour/minute cron settings, with
JSONification of the report
<pre>
  lynis::profile { 'my_profile':
    profile_name  => 'my_profile',
    source        => 'puppet:///data/lynis/my_profile.prf',
    cron          => true,
    logstashify   => true,
  }
</pre>


Known Issues:
-------------
Only tested on CentOS 6

License:
_______

Released under the Apache 2.0 licence


Contribute:
-----------
* Fork it
* Create a topic branch
* Improve/fix
* Push new topic branch
* Submit a PR
