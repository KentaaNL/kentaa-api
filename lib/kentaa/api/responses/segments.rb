# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Segments < Base
        include Enumerable
        include Kentaa::Api::Responses::Pagination

        def initialize(response)
          super(response)
        end

        def each(&block)
          segments.each(&block)
        end

        private

        def segments
          @segments ||= begin
            segments = []

            if data[:segments]
              data[:segments].each do |segment|
                segments << Kentaa::Api::Responses::Segment.new(segment)
              end
            end

            segments
          end
        end
      end
    end
  end
end
