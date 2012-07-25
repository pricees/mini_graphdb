$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

ENV['ENV'] = 'test'

require 'rubygems'
require 'mini_graphdb'
require 'minitest/autorun'
require 'mocha'
