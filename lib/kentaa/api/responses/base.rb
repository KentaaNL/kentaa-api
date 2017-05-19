module Kentaa
  module Api
    module Responses
      class Base
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def error?
          !message.nil?
        end

        def message
          data[:message]
        end
      end
    end
  end
end
