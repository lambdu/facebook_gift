require File.join(File.dirname(__FILE__), 'fb_gift_creator')
require File.join(File.dirname(__FILE__), 'fb_gift_parser')

URL = 'URL'.freeze
USERNAME = 'USERNAME'.freeze
PASSWORD = 'PASSWORD'.freeze

if ARGV.length != 1
  puts "This file requires one argument: filename of xls document"
  exit
end

parser = FbGiftParser.new
subscriptions = parser.sheet_to_hash(ARGV[0])
creator = FbGiftCreator.new(USERNAME, PASSWORD, URL)
print "entering subscription information "
subscriptions.each do |subscription|
  creator.create(subscription)
  print "."
end
