# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      module Pagination
        attr_accessor :body

        def links
          body[:links]
        end

        def pages
          links[:pages] if links
        end

        def total_entries
          body[:total_entries]
        end

        def total_pages
          body[:total_pages]
        end

        def per_page
          body[:per_page]
        end

        def current_page
          body[:current_page]
        end

        def next_page
          current_page + 1 if next_page?
        end

        def next_page?
          current_page && current_page < total_pages
        end

        def previous_page
          current_page - 1 if previous_page?
        end

        def previous_page?
          current_page && current_page > 1
        end
      end
    end
  end
end
