$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'lymbix/configuration'
require 'lymbix/request'
require 'lymbix/response'
require 'lymbix/base'
