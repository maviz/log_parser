# frozen_string_literal: true

require 'spec_helper'
require 'json'
require_relative '../main'

describe 'result calculation test' do
  let(:log_file) { 'webserver.log' }
  let(:first_path) do
    # getting the first path to avoid hardcoding any paths, so we can change the logfile and test
    `head -n 1 #{log_file}`.split(' ').first
  end

  let(:test_count) do
    # this count the occurance the first path using bash cat and grep commands

    JSON.parse(`cat #{log_file} | grep -o #{first_path} | wc -l`)
  end

  it 'expects the test count equals to count by our class' do
    # no side of this test is hard coded, left side is the count for path on
    # the first line computed by our class,
    # right side is the count of all occurances of the path on the first line
    # take by bash commands. If these match, our class is good

    expect(Main.execute([log_file]).result[first_path][:count]).to eq(test_count)
  end
end
