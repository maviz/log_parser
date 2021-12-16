# frozen_string_literal: true

# this class is mainly responsible for displaying the results in console.
# this displays the rsults is desired format and also shows validation error.
# Errors in the lines are shown also.
class ResultLogger
  attr_accessor :result

  def initialize(parser:)
    @result = parser.result
    process
  end

  private

  def process
    return file_empty if result.empty?
    return print_file_error if result.key?(:error)

    print_result
  end

  def print_result
    print_results_by_page_visits
    print_results_by_unique_page_visits

    result.to_a.reject { |el| el[1][:error].nil? }.each do |el|
      puts "Error: #{el[0]} on line ##{el[1][:linenos].join(',')}"
    end
  end

  def print_results_by_unique_page_visits
    result_by_uniq_page_visits.select { |el| el[1][:error].nil? }.each do |el|
      puts "#{el[0]} #{el[1][:uniq_count]} unique ip visits"
    end
  end

  def print_results_by_page_visits
    result_by_page_visits.select { |el| el[1][:error].nil? }.each do |el|
      puts "#{el[0]} #{el[1][:count]} visits"
    end
  end

  def file_empty
    puts 'Nothing found after parsing the file'
  end

  def print_file_error
    puts result[:error]
  end

  def result_by_page_visits
    sort_by(sort_attr: :count)
  end

  def result_by_uniq_page_visits
    sort_by(sort_attr: :uniq_count)
  end

  def sort_by(sort_attr:)
    @result.sort do |(_k1, v1), (_k2, v2)|
      (v2[sort_attr].nil? ? 0 : v2[sort_attr]) <=> (v1[sort_attr].nil? ? 0 : v1[sort_attr])
    end
  end
end
