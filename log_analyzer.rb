require 'forwardable'

class LogAnalyzer
  extend Forwardable

  def initialize(file = nil)
    @file = file
    @requests = Hash.new { |h, k| h[k] = Hash.new(0) }
  end

  def analyse
    file_present? && parse_log and print_analytics
  end

  private

  def parse_log
    File.readlines(@file).each do |line|
      return false unless valid?(line.strip)

      path, ip_address = line.strip.split(' ').map(&:to_sym)
      @requests[path][ip_address] += 1
    end
  end

  def print_analytics
    @log_analytics ||= LogAnalytics.new(@requests).print_statistics
  end

  def valid?(line)
    return true if /\/\w+(\/\w*)*\s(\d{3}\.){3}\d{3}/ =~ line

    print "Wrong format of log found on line #{line}"
  end

  def file_present?
    return true if @file

    print 'Please add path of log file to parse'
  end
end