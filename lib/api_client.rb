require './lib/api.rb'
require 'nokogiri'
 
# CRUD example with an api
 
def list_tasks(api_object)
  puts "Current Tasks:"
  doc = Nokogiri::XML.parse api_object.read
  puts doc
  descriptions = doc.xpath('tasks/task/description').collect {|e| e.text }
  puts descriptions.join(", ")
  puts ""
end
 
api = Api.new
list_tasks(api)
 
# Create
puts "Creating someone..."
api.create "Bobby Flay"
list_tasks(api)
 
# Read one and do nothing with it
api.read 1
 
# Read all and get valid IDs
doc = Nokogiri::XML.parse api.read
ids = doc.xpath('tasks/task/id').collect {|e| e.text }
 
# Update last record
puts "Updating last record ..."
api.update ids.last, "Robert Flaid"
list_tasks(api)
 
# Delete
puts "deleting last record ..."
api.delete ids.last
list_tasks(api)