# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      module Pagination
        def links
          data[:links]
        end

        def pages
          links[:pages] if links
        end

        def total_entries
          data[:total_entries]
        end

        def total_pages
          data[:total_pages]
        end

        def per_page
          data[:per_page]
        end

        def current_page
          data[:current_page]
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
