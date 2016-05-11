require_relative 'json2csv/lib/json_to_csv'

def get_file_name(original_file)
  converted_file = original_file.gsub(/\.\w*$/, '') + '.csv'
end

if !ARGV[0].nil? && !ARGV[1].nil?
  JsonToCsv.new(ARGV[0]).convert(ARGV[1])
elsif !ARGV[0].nil?
  JsonToCsv.new(ARGV[0]).convert(get_file_name(ARGV[0]))
else
  puts "Usage:"
  puts '  ruby convert.rb input [output]'
end
