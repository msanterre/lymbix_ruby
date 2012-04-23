require 'json'

module Lymbix
  class Response

    attr_accessor :data, :success

    def initialize(response)
      unless response == "null"
        begin
          @data = JSON.parse(response.to_s)
          unless @data.class == Array
            if @data["success"] == "false"
              @success = false
            else
              @success = true
            end
          else
            @success = true
          end
        rescue
        @success = false
        @data = response.to_s
        end
      else
        @success = false
        @data = response.to_s
      end
    end

  end
end
