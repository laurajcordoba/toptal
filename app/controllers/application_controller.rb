class ApplicationController < ActionController::Base
  # protect_from_forgery

  protected
  def http_basic_authentication
    if request.format == Mime::XML
      authenticate_or_request_with_http_basic do |username, password|
        username == 'foo' && password == 'bar'
      end
    end
  end

end
