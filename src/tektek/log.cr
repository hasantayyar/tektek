module Tektek
 class Logger
    def self.summary
      # @todo : add transferred data size statistic
      puts "________________________\n\n"
      puts "Elapsed time : #{Tektek.stats.total_time} ms"
      puts "Transactions : #{Tektek.stats.requests.size} hits"
      puts "Shortest transaction : #{Tektek.stats.min_req_time} ms"
      puts "Longest transaction  : #{Tektek.stats.max_req_time} ms"
      puts "Average transaction  : #{Tektek.stats.total_time/Tektek.stats.requests.size} ms\n"
      puts "________________________"
      puts "Transaction rate : #{1000/ (Tektek.stats.total_time/Tektek.stats.requests.size)} trans/sec"
      puts "Successful transactions #{Tektek.stats.ok_requests}"
      puts "Failed transactions #{Tektek.stats.not_ok_requests}"
    end
  end
end
