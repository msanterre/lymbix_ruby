require 'rest_client'
require 'json'

module Lymbix
  class Request
    attr_accessor :url, :http_method, :response, :method, :object, :header_hash
    
    def initialize(http_method, method, header_hash, object = nil) #:nodoc:
      self.http_method = http_method
      self.url = Lymbix::Configuration.host
      self.method = method
      self.object = object
      self.header_hash = header_hash
    end
    
    def connection
      options = {}
      options[:timeout] = 60
      options[:headers] = {:USER_AGENT => "Lymbix Gem - 0.4.5", :accept => self.header_hash[:accept_type], :AUTHENTICATION => self.header_hash[:auth_key], :VERSION => self.header_hash[:version]}            
      RestClient::Resource.new(self.url, options)
    end
    
    def run
      case(self.http_method)
      when :get
        self.connection[self.method].get do |resp|
          self.response = resp.body
        end
      when :post
        self.connection[self.method].post(object) do |resp|
          self.response = resp.body
        end
      end
      Response.new(self.response)
    end
  end
end