module Kentaa
  module Api
    module Responses
      class Banner < Base
        include Kentaa::Api::Responses::Resource

        def initialize(response)
          super(response)
        end

        def url
          data[:url]
        end

        def text
          data[:text]
        end

        def link
          data[:link]
        end

        def locale
          data[:locale]
        end
      end
    end
  end
end
