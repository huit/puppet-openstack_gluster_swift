require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint'

PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.ignore_paths = ["pkg/**/*.pp", "tests/*.pp", "spec/**/*.pp"]
PuppetLint.configuration.send('disable_80chars')
