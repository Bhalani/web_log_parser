#!/usr/bin/env ruby
require_relative './log_analytics'

module Parser
  autoload(:LogAnalyzer, './log_analyzer.rb')

  LogAnalyzer.new(ARGV[0]).analyse
end
