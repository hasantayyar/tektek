module Tektek
  class Load
    def initialize(@host : String, @request_number : Int32)
      Tektek.create_stats @request_number

      ch = Channel(Nil).new
      uri = URI.parse @host
      client = HTTP::Client.new uri.host.not_nil!, port: uri.port

      # async requests
      # threding like in [crystal-lang/crystal/issues/1967](https://github.com/crystal-lang/crystal/issues/1967)
      spawn do
        loop do
          request = Request.new client, uri
          Tektek.stats << request
          ch.send nil
        end
      end

      # listen channel
      loop do
        if Tektek.stats.requests.size == Tektek.stats.request_number
          self.summary
          exit
        end
        ch.receive
      end

    end

    def summary
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

