require_relative 'test_helper'

class LogAnalyzerTest < Minitest::Test
  context 'When file is absent' do
    should 'return message of provide file path' do
      analyzer = LogAnalyzer.new()
      out = capture_io { analyzer.analyse }

      assert_equal out.first, 'Please add path of log file to parse'
    end
  end

  context 'When any log entry is in invalid format' do
    should 'return message with the line having invalid format' do
      analyzer = LogAnalyzer.new('./fixtures/wrong_webserver.log')
      out = capture_io do
        analyzer.analyse
      end

      assert_equal out.first, 'Wrong format of log found on line /contact ads184.123.665.067'
    end
  end

  context 'When Having file with valid log records' do
    should 'return the result in alphabetical order of path' do
      analyzer = LogAnalyzer.new('./fixtures/webserver.log')

      out = capture_io do
        analyzer.analyse
      end

      assert_equal out.first, "\nTotal uniq path in logs 6\n\nTotal requests count 500\n\nTotal unique IPs 23\n\nOne Time Visitpr IPs per page\n/about/2 4\n/index 4\n/about 3\n/help_page/1 3\n/contact 2\n/home 2\n\nUniq IP per page\n/contact 23\n/help_page/1 23\n/home 23\n/index 23\n/about/2 22\n/about 21\n\nTotal View Counts\n/about/2 90\n/contact 89\n/index 82\n/about 81\n/help_page/1 80\n/home 78\n"
    end
  end
end
