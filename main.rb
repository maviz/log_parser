#!/usr/bin/ruby
# frozen_string_literal: true

require './file_parser'
require './result_logger'

# this is the main class which executes the script by instantiating the FileParse
# and passing args to it. Validation is done on file argument and file contents line by line.
class Main
  def self.execute(args)
    parser = FileParser.new(args: args, seperator: ' ')
    ResultLogger.new(parser: parser)
  end
end

Main.execute(ARGV)
