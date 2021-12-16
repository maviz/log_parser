# frozen_string_literal: true

require 'spec_helper'
require 'json'
require_relative '../main'

describe 'test line parser with valid line' do
  let(:test_line) { '/about 336.284.013.698' }
  let(:valid_result) { { '/about' => { count: 1, ips: ['336.284.013.698'], uniq_count: 1 } } }

  it 'expects valid results for a valid line' do
    expect(LineParser.new(result: {}, line: test_line).result).to eq(valid_result)
  end
end

describe 'test line parser with in valid ip' do
  let(:test_line) { '/about xxx.284.yyy.698' }
  let(:result) { { invalid_ip: { error: true, linenos: [1] } } }

  it 'expects invalid_ip error added in the result for line with invalid ip' do
    expect(LineParser.new(result: {}, line: test_line, lineno: 1).result.key?(:invalid_ip)).to eq(true)
    expect(LineParser.new(result: {}, line: test_line, lineno: 1).result).to eq(result)
  end
end

describe 'test line parser with a blank line' do
  let(:test_line) { '' }
  let(:result) { { blank_line: { error: true, linenos: [1] } } }

  it 'expects blank_line error added in the result for blank line' do
    expect(LineParser.new(result: {}, line: test_line, lineno: 1).result.key?(:blank_line)).to eq(true)
    expect(LineParser.new(result: {}, line: test_line, lineno: 1).result).to eq(result)
  end
end
