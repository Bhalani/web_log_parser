require_relative 'test_helper'

require 'pry'

class LogAnalyticsTest < Minitest::Test
  context '#print_statistics' do
    should 'print all the statistics built in' do
      log_entries = {
        '/about': {
          'ip1': 2,
          'ip2': 2
        },
        '/index': {
          'ip2': 1,
          'ip3': 3
        },
        '/home': {
          'ip2': 1,
          'ip3': 3,
          'ip1': 2
        }
      }

      log_analytics = LogAnalytics.new(log_entries)

      out = capture_io do
        log_analytics.print_statistics
      end

      assert_equal out.first, "\nTotal uniq path in logs 3\n\nTotal request IPs count 14\n\nTotal unique IPs 3\n\nOne Time Visitpr IPs per page\n/home 1\n/index 1\n/about 0\n\nUniq IP per page\n/home 3\n/about 2\n/index 2\n\nTotal View Counts\n/home 6\n/about 4\n/index 4\n"
    end
  end

  context 'private methods' do
    context '#total_logs_per_page' do
      should 'return number of logs found for each page' do
        log_entries = {
          '/about': {
            'ip1': 2,
            'ip2': 2
          },
          '/index': {
            'ip2': 1,
            'ip3': 3
          }
        }

        expected_output = { '/about': 4, '/index': 4 }

        log_analytics = LogAnalytics.new(log_entries)
        assert_equal log_analytics.send('total_logs_per_page'), expected_output
      end
    end

    context '#one_time_logged_ips_per_page' do
      should 'return number of single time visitor ip found for each page' do
        log_entries = {
          '/about': {
            'ip1': 2,
            'ip2': 2
          },
          '/index': {
            'ip2': 1,
            'ip3': 3
          }
        }

        expected_output = { '/about': 0, '/index': 1 }
        log_analytics = LogAnalytics.new(log_entries)
        assert_equal log_analytics.send('one_time_logged_ips_per_page'), expected_output
      end
    end

    context '#uniq_request_ip_per_page' do
      should 'return number of single time visitor ip found for each page' do
        log_entries = {
          '/about': {
            'ip1': 2,
            'ip2': 2
          },
          '/index': {
            'ip2': 1,
            'ip3': 3,
            'ip1': 2
          }
        }

        expected_output = { '/about': 2, '/index': 3 }

        log_analytics = LogAnalytics.new(log_entries)
        assert_equal log_analytics.send('uniq_request_ip_per_page'), expected_output
      end
    end
  end
end
