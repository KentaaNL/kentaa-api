# frozen_string_literal: true

module Kentaa
  module Api
    class Finder
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def by_object_key(object_key)
        klass, id = object_key.split("_")

        case klass
        when "Action"
          client.actions.get(id)
        when "Project"
          client.projects.get(id)
        when "Segment"
          client.segments.get(id)
        when "Site"
          client.sites.current
        when "Team"
          client.teams.get(id)
        end
      end
    end
  end
end
