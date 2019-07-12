# frozen_string_literal: true

module Kentaa
  module Api
    class Finder
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def by_object_key(object_key)
        klass, id = object_key.split("_")

        case klass
        when "Action"
          client = Kentaa::Api::Clients::Actions.new(config)
          client.get(id)
        when "Project"
          client = Kentaa::Api::Clients::Projects.new(config)
          client.get(id)
        when "Segment"
          client = Kentaa::Api::Clients::Segments.new(config)
          client.get(id)
        when "Site"
          client = Kentaa::Api::Clients::Sites.new(config)
          client.current
        when "Team"
          client = Kentaa::Api::Clients::Teams.new(config)
          client.get(id)
        end
      end
    end
  end
end
