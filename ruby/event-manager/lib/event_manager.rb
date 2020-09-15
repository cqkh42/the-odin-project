# frozen_string_literal: true

require 'csv'
require 'Date'
require 'erb'
require 'google/apis/civicinfo_v2'

puts 'EventManager Initialized!'

def clean_zipcode(zipcode)
  zipcode.to_s[0..4].rjust 5, '0'
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  legislators = civic_info.representative_info_by_address(
    address: zipcode,
    levels: 'country',
    roles: %w[legislatorUpperBody legislatorLowerBody]
  )
  legislators.officials
rescue Google::Apis::ClientError
  'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
end

def save_letter(id, letter)
  Dir.mkdir('output') unless Dir.exist? 'output'
  filename = "output/thanks_#{id}.html"
  File.open(filename, 'w') { |file| file.puts letter }
end

def clean_phone_number(num)
  num = num.gsub(/[^0-9]/, '')
  num = num[1..-1] if num.length == 11 && num[0] == '1'
  num = '0' * 10 if num.length != 10
  num
end

template_letter = File.read 'form_letter.erb'
erb_template = ERB.new template_letter

hours = Hash.new 0
wdays = Hash.new 0

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(row[:zipcode])
  form_letter = erb_template.result(binding)
  save_letter(row[0], form_letter)

  phone_number = clean_phone_number(row[:homephone])
  reg_time = DateTime.strptime(row[:regdate], '%m/%d/%y %H:%M')
  hours[reg_time.hour.to_s] += 1
  wdays[reg_time.wday.to_s] += 1

  puts "#{name}, #{zipcode}, #{phone_number}"
end
puts hours
puts wdays
