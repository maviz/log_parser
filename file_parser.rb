#!/usr/bin/ruby
# frozen_string_literal: true

require './line_parser'
require './validators'

# this is the FileParser class which takes the path from the main class and processes file
# line by line and compiles a results hash as it itterates through the lines.
class FileParser
  include Validator
  attr_accessor :file_path, :seperator, :result, :args

  def initialize(args: nil, seperator: ' ')
    @seperator = seperator
    @args = args
    @file_path = args[0]
    @result = {}
    process_file
  end

  private

  def process_file
    return unless valid?

    File.open(file_path).inject(result) do |_result, line|
      LineParser.new(seperator: seperator, result: @result, line: line.strip)
    end
  end
end
