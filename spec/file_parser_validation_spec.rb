# frozen_string_literal: true

require 'spec_helper'
require 'json'
require_relative '../main'

describe 'file parser validation tests' do
  let(:no_argument_passed) { 'No arguments passed.' }
  let(:file_not_exists) { 'The log file doesn\'t exists.' }
  let(:file_invalid_ext) { 'The file is not a valid log file.' }

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
end
