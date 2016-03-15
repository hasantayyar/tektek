module Tektek
  class Load
    def initialize(@host : String, @req_number : Int32)
      Tektek.create_stash @req_number

      ch = Channel(Nil).new
      uri = URI.parse @host
      client = HTTP::Client.new uri.host.not_nil!, port: uri.port

      # async requests
      # threding like in [crystal-lang/crystal/issues/1967](https://github.com/crystal-lang/crystal/issues/1967)
      spawn do
        loop do
          request = Request.new client, uri
          Tektek.stash << request
          ch.send nil
        end
      end

      # listen channel
      loop do
        if Tektek.stash.reqs.size == Tektek.stash.req_number
          self.summary
          exit
        end
        ch.receive
      end

    end

    def summary
      # @todo : add transferred data size statistic
      stash = Tektek.stash
      time = stash.total_time
      reqs = stash.reqs
      size = reqs.size
      puts "________________________\n\n"
      puts "Elapsed time : #{time} ms"
      puts "Transactions : #{size} hits"
      puts "Shortest transaction : #{reqs.map(&.time_ab as Float64).min} ms"
      puts "Longest transaction  : #{reqs.map(&.time_ab as Float64).max} ms"
      puts "Average transaction  : #{time/size} ms\n"
      puts "________________________"
      puts "Transaction rate : #{1000/ (time/size)} trans/sec"
      puts "Successful transactions #{stash.ok_reqs}"
      puts "Failed transactions #{stash.not_ok_reqs}"
    end
  end
end

