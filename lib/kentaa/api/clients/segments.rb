# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Segments < Base
        def all(options = {})
          segments = Kentaa::Api::Resources::Segments.new(config, options)
          segments.all
        end

        def list(options = {})
          segments = Kentaa::Api::Resources::Segments.new(config, options)
          segments.load
        end

        def get(id, options = {})
          segment = Kentaa::Api::Resources::Segment.new(config, options.merge(id: id))
          segment.load
        end
      end
    end
  end
end
