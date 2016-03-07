module Tektek
  class Cli
    def initialize
      @options = {} of Symbol => String
      @options[:num] = "100"
      OptionParser.parse(ARGV) do |options|
        options.banner = "Usage: ./tektek [options]"
        options.on("-u URL", "Target url") { |url|  @options[:url] = url }
        options.on("-n REQ. NUMBERS", "Number of requests to make") { |num| @options[:num] = num }
        options.on("-h", "Print help this message") { puts options }
      end
      # @todo check options are valid
      Tektek::Load.new @options[:url], @options[:num].to_i
    end

  end
end
