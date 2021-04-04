class LogAnalytics
  def initialize(log_entries = [])
    @log_entries = log_entries
  end

  def print_statistics
    print_uniq_page_count
    print_total_request_count
    print_total_count_of_request_ips
    print_one_time_logged_ips_per_page
    print_uniq_ips_per_page
    print_total_logs_per_page
  end

  private

  def print_uniq_page_count
    puts "\nTotal uniq path in logs #{log_entries.length}"
  end

  def print_total_request_count
    puts "\nTotal requests count #{@log_entries.values.map(&:values).flatten.sum}"
  end

  def print_total_count_of_request_ips
    puts "\nTotal unique IPs #{@log_entries.values.map(&:keys).flatten.uniq.count}"
  end

  def print_one_time_logged_ips_per_page
    puts "\nOne Time Visitpr IPs per page"
    print_it(one_time_logged_ips_per_page)
  end

  def print_uniq_ips_per_page
    puts "\nUniq IP per page"
    print_it(uniq_request_ip_per_page)
  end

  def print_total_logs_per_page
    puts "\nTotal View Counts"
    print_it(total_logs_per_page)
  end

  def print_it(statistics)
    order_decending(statistics).each do |path, count|
      puts "#{path} #{count}"
    end
  end

  def one_time_logged_ips_per_page
    log_entries.reduce(Hash.new(0)) do |entries, (path, ips) |
      entries[path] = ips.select {|ip, count| count == 1 }.length
      entries
    end
  end

  def total_logs_per_page
    log_entries.reduce(Hash.new(0)) do |entries, (path, ips) |
      entries[path] = ips.values.sum
      entries
    end
  end

  def uniq_request_ip_per_page
    log_entries.reduce(Hash.new(0)) do |entries, (path, ips) |
      entries[path] = ips.keys.length
      entries
    end
  end

  def order_decending(log_entry)
    log_entry.sort_by { |path, count| [-count, path] }
  end

  attr_reader :log_entries
end
