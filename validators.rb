# frozen_string_literal: true

require 'English'

# this is the validation module, included in file and line parser, this gives these classes
# the valid? function
# while validating line, we keep track of the line number show that when logging error so we know
# what error occured in which line.
module Validator
  def valid?
    if instance_of?(LineParser)
      line_validator
    elsif instance_of?(FileParser)
      file_validator
    else
      false
    end
  end

  private

  def line_validator
    # checks lines for a valid format i.e should not be blank and
    # second part after the space should be valid ip

    return blank_line if line.empty?

    parts = line.split(seperator)
    return add_invalid_ip if not_an_ip? parts[1]

    true
  end

  def not_an_ip?(str)
    # simple ip format check, regex could be used alse

    return true if str.split('.').count < 4
    return true if non_int_index? str

    false
  end

  def non_int_index?(str)
    # checks that all parts of ip are valid integers
    # trimming leading zeros, converting to ineter and back to string
    # matchs the zeros trimmed charecter for valid integers
    str.split('.').map do |ch|
      ch.sub(/^0+/, '').to_i.to_s == ch.sub(/^0+/, '')
    end.include?(false)
  end

  def file_validator
    # checks that arguments passed are not empty, files exists
    # and is of a valid extension i.e .log

    if args.empty? || no_file? || invalid_format?
      result[:error] = 'No arguments passed.' if args.empty?
      result[:error] = 'The log file doesn\'t exists.' if no_file?
      result[:error] = 'The file is not a valid log file.' if invalid_format?
      false
    else
      true
    end
  end

  def add_invalid_ip
    result[:invalid_ip] ||= {}
    init_count(:invalid_ip)
    false
  end

  def blank_line
    result[:blank_line] ||= {}
    init_count(:blank_line)
    false
  end

  def init_count(key)
    result[key][:linenos] ||= []
    result[key][:linenos].push(lineno || $INPUT_LINE_NUMBER)
    result[key][:error] = true
  end

  def invalid_format?
    return unless result[:error].nil?

    args[0]&.split('.')&.last&.strip != 'log'
  end

  def no_file?
    return unless result[:error].nil?

    !File.exist?(args[0] ||= '')
  end
end
