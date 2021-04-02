# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Segments < List
        include Enumerable

        def each(&block)
          segments.each(&block)
        end

        private

        def load_resource
          request.get("/segments", options)
        end

        def segments
          @segments ||= begin
            segments = []

            if data
              data.each do |segment|
                segments << Kentaa::Api::Resources::Segment.new(config, data: segment, options: options)
              end
            end

            segments
          end
        end
      end
    end
  end
end
