require 'csv'
require 'json'
require_relative 'parser'

class JsonToCsv
  def initialize(input)
    @input_file = input
  end

  def convert(output = nil)
    json_file = JSON.parse( IO.read(@input_file) )
    csv = generate_csv(Parser.new(json_file[0]).get_keys, json_file)
    IO.write(output, csv) unless output.nil?
    csv
  end

  def generate_csv(keys, object)
    csv_string = CSV.generate do |csv|
      csv << keys
      object.each do |hash|
        csv << Parser.new(hash).get_values
      end
    end
    csv_string
  end
end
