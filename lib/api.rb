require 'net/http'
 
class Api
  attr_accessor :url
  attr_accessor :uri
 
  def initialize
    @url = "http://localhost:3000/tasks"
    @uri = URI.parse @url
  end
 
  # Create a task using a predefined XML template as a REST request.
  def create(description="Default Description")
    xml_req =
    "<?xml version='1.0' encoding='UTF-8'?>
    <task>
      <description>#{description}</description>
    </task>"
    request = Net::HTTP::Post.new(@url)
    request.add_field "Content-Type", "application/xml"
    request.body = xml_req
    
    http = Net::HTTP.new(@uri.host, @uri.port)
    response = http.request(request)
    
    puts response.body
    
    response.body    
  end
 
  # Read can get all tasks with no arguments or
  # get one task with one argument.  For example:
  # api = Api.new
  # api.read 2 => one task
  # api.read   => all tasks
  def read(id=nil)
    request = Net::HTTP.new(@uri.host, @uri.port)
 
    if id.nil?
      response = request.get("#{@uri.path}.xml")      
    else
      response = request.get("#{@uri.path}/#{id}.xml")    
    end
 
    response.body
  end
 
  # Update a task using a predefined XML template as a REST request.
  def update(id, description="Updated Description", extension=0000)
    xml_req =
    "<?xml version='1.0' encoding='UTF-8'?>
    <task>
      <extension type='integer'>#{extension}</extension>
      <id type='integer'>#{id}</id>
      <description>#{description}</description>
    </task>"
 
    request = Net::HTTP::Put.new("#{@url}/#{id}.xml")
    request.add_field "Content-Type", "application/xml"
    request.body = xml_req
 
    http = Net::HTTP.new(@uri.host, @uri.port)
    response = http.request(request)
 
    # no response body will be returned
    case response
    when Net::HTTPSuccess
      return "#{response.code} OK"
    else
      return "#{response.code} ERROR"
    end
  end
 
  def delete(id)
    request = Net::HTTP::Delete.new("#{@url}/#{id}.xml")
    http = Net::HTTP.new(@uri.host, @uri.port)
    response = http.request(request)
 
    # no response body will be returned
    case response
    when Net::HTTPSuccess
      return "#{response.code} OK"
    else
      return "#{response.code} ERROR"
    end
  end
 
end