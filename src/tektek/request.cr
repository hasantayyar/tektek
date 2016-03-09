module Tektek
  class Request
    def initialize(http_client, uri)
      @time_a = Time.now
      # @todo - custom methods will be given as option, like POST PUT
      res = http_client.get uri.full_path
      @time_b = Time.now
      @status_code = res.status_code
    end

    def is_success
        @status_code == 200 || @status_code == 301 || @status_code == 302
    end

    def time_ab
      ((@time_b - @time_a) * 1000).to_f
    end
  end
end
