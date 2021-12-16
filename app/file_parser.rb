#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'line_parser'
require_relative 'validators'

# this is the FileParser class which takes the path from the main class and processes file
# line by line and compiles a results hash as it itterates through the lines.
class FileParser
  include Validator
  attr_accessor :file_path, :seperator, :result, :args, :logger

  def initialize(args: nil, seperator: ' ', logger: nil)
    @seperator = seperator
    @args = args
    @file_path = args[0]
    @result = {}
    @logger = logger
    process_file
    log_results unless logger.nil?
  end

  private

  def log_results
    return unless Object.const_defined?(logger.to_s)

    logger.new(parser: self)
  end

  def process_file
    return unless valid?

    File.open(file_path).inject(result) do |_result, line|
      LineParser.new(seperator: seperator, result: @result, line: line.strip)
    end
  end
end
