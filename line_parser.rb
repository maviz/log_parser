#!/usr/bin/ruby
# frozen_string_literal: true

require './validators'

# this is the line parser class responsible for parsing a line from logs and
# making changes to the result hash accordingly. result hash is like an accumulator initialized and kept
# by the FileParsor instance and passed on to each LineParsor instance to be updated.
class LineParser
  include Validator
  attr_accessor :line, :seperator, :result, :lineno

  def initialize(result:, line:, seperator: ' ', lineno: nil)
    @seperator = seperator
    @line = line
    @result = result
    @lineno = lineno
    process_line
  end

  private

  def process_line
    return unless valid?

    line_arr = @line.split(@seperator)
    req_path = line_arr[0]
    ip = line_arr[1]
    result.key?(req_path) ? repeted_path(req_path, ip) : new_path(req_path, ip)
    result
  end

  def repeted_path(req_path, ip)
    result[req_path][:uniq_count] += 1 unless @result[req_path][:ips].include?(ip)
    result[req_path][:ips].push(ip)
    result[req_path][:count] += 1
  end

  def new_path(req_path, ip)
    result[req_path] = {}
    result[req_path][:ips] = []
    result[req_path][:ips].push(ip)
    result[req_path][:count] = 1
    result[req_path][:uniq_count] = 1
  end
end
