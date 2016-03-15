require "./Tektek/*"
require "http"
require "option_parser"

module Tektek
  def self.create_stash(req_number)
      @@stash = Stash.new req_number
  end

  def self.stash
    @@stash.not_nil!
  end

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
      Tektek::Load.new @options[:url], @options[:num].to_i
    end
  end
end

Tektek::Cli.new



