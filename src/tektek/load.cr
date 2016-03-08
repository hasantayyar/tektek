module Tektek
  class Load
    def initialize(@host : String, @req_num : Int32)

      ch = Channel(Nil).new
      uri = URI.parse @host
      client = HTTP::Client.new uri.host.not_nil!, port: uri.port

      # async requests
      # threding like in [crystal-lang/crystal/issues/1967](https://github.com/crystal-lang/crystal/issues/1967)
      spawn do
        loop do
          request = Request.new client, uri
          ch.send nil
        end
      end

      # listen channel
      loop do
        ch.receive
      end

    end
  end

  class Request

    def initialize(http_client, uri)
      @time_a = Time.now
      response = http_client.get uri.full_path
      @time_b = Time.now
      @status_code = response.status_code
    end

    def is_success
        @status_code == 200 || @status_code == 301 || @status_code == 302
    end

    def time_ab
      (@time_b - @time_a).to_f * 1000.0
    end
  end
end

