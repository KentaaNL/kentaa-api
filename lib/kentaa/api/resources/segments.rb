# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Segments < List
        include Enumerable

        def each(&block)
          segments.each(&block)
        end

        protected

        def load_resource(options)
          request.get("/segments", options)
        end

        private

        def segments
          @segments ||= begin
            segments = []

            if data
              data.each do |segment|
                segments << Kentaa::Api::Resources::Segment.new(config, data: segment)
              end
            end

            segments
          end
        end
      end
    end
  end
end
