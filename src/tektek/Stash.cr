module Tektek

  class Stash
    Requests = [] of Request

    getter :req_count
    getter :req_number

    def initialize(@req_number)

    end

    def ok_reqs
      (req_statuses - [false]).size
    end

    def not_ok_reqs
      (req_statuses - [true]).size
    end

    def reqs
      Requests
    end

    def <<(request)
      Requests << request
    end

    def total_time
      Requests.map(&.time_ab as Float64).sum
    end

    private def req_statuses
      Requests.map(&.is_success as Bool)
    end
  end



end
