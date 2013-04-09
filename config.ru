require 'rubygems'
require 'bundler'
Bundler.require

$LOAD_PATH.unshift 'lib'
require 'tincan'
require 'puma'

run Tincan::Application
