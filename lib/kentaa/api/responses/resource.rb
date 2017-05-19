require 'time'

module Kentaa
  module Api
    module Responses
      module Resource
        def id
          data[:id]
        end

        def created_at
          Time.parse(data[:created_at]) if data[:created_at]
        end

        def updated_at
          Time.parse(data[:updated_at]) if data[:updated_at]
        end
      end
    end
  end
end
