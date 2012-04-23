module Lymbix
  
  class Configuration
    
    attr_accessor :host

    @@host = "http://api.lymbix.com"
    
    def self.host
      @@host
    end
    
    def self.host=(host)
      @@host = host
    end
  end
end