# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Segments < Base
        include Enumerable
        include Kentaa::Api::Resources::Pagination

        def each(&block)
          segments.each(&block)
        end

        private

        def segments
          @segments ||= begin
            segments = []

            if data
              data.each do |segment|
                segments << Kentaa::Api::Resources::Segment.new(config, segment)
              end
            end

            segments
          end
        end
      end
    end
  end
end
