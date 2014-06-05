#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'time'

report = {}

#File.open("/var/log/lynis-report.dat", "r") do |infile|
File.open("/var/log/lynis-report.dat", "r") do |infile|
  while ( line = infile.gets )
    # Ignore comments
    next if line.match(/\s*#/)

    # Split kv pairs
    line.strip!
    kv = line.split('=', 2)

    if kv[1].match(/.*\|.*\|/) # extra processing for double bars
      if kv[0] == 'tests_executed' || kv[0] == 'tests_skipped'  # list of tests
        kv[1] = kv[1].split('|')
      else  # in the format "control|text|", "package||", "ip:port|protocol|program", "path|unknown entity|"
        tmp = kv[1].split('|')
        if tmp[0].match(/^\w+\-\d+$/)
          kv[1] = { :control => tmp[0], :description => tmp[1] }
        elsif kv[0] = 'installed_package'
          kv[1] = tmp[0]
        elsif tmp[0].match(/^[a-f\d:\.]+$/)
          kv[1] = { :ip => tmp[0], :protocol => tmp[1], :program => tmp[2] }
        elsif tmp[0].match(/[\/\w\d\.\-]/)
          kv[1] = { :path => tmp[0] }
        end
      end
    end

    if kv[0][-2,2] == '[]' # If the key is an array
      kv[0] = kv[0].chomp('[]')

      report[kv[0]] ||= []
      report[kv[0]].push(kv[1])
    else
      report[kv[0]] = kv[1]
    end
  end
end

# Set logstash vars
report['@timestamp'] = Time.parse(report['report_datetime_start']).iso8601
report['@version'] = 1

File.open("/var/log/lynis-report.json", "a") do |outfile|
  outfile.puts report.to_json
end
