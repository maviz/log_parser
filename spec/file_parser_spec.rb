# frozen_string_literal: true

require 'spec_helper'
require 'json'
require_relative '../main'

describe 'file parser test' do
  let(:no_argument_passed) { 'No arguments passed' }
  let(:file_not_exists) { 'The log file doesn\'t exists' }
  let(:file_invalid_ext) { 'The file is not a valid log file' }

  let(:log_file) { 'webserver.log' }

  let(:first_path) do
    # getting the first path to avoid hardcoding any paths, so we can change the logfile and test
    `head -n 1 #{log_file}`.split(' ').first
  end

  let(:test_count) do
    # this count the occurance of a path, first path using bash cat and grep commands
    JSON.parse(`cat #{log_file} | grep -o #{first_path} | wc -l`)
  end

  it 'should tell if no file argument is passed' do
    expect(Main.execute([]).result[:error]).to eq(no_argument_passed)
  end

  it 'should tell if file argument is passed but file is not present' do
    expect(Main.execute(['log.log']).result[:error]).to eq(file_not_exists)
  end

  it 'should tell if file argument is passed but file is invalid extension' do
    expect(Main.execute(['main.rb']).result[:error]).to eq(file_invalid_ext)
  end

  it 'should not return error if valid file is passed' do
    expect(Main.execute(['webserver.log']).result.key?(:error)).to eq(false)
  end

  it 'should have the FileParser class defined' do
    expect(Object.const_defined?('FileParser')).to eq(true)
  end

  it 'should have the LineParser class defined' do
    expect(Object.const_defined?('LineParser')).to eq(true)
  end

  it 'expects the test count equals to count by class' do
    expect(Main.execute([log_file]).result[first_path][:count]).to eq(test_count)
  end
end
