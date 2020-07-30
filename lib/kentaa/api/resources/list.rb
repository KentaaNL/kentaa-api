# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class List < Base
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

        def next
          self.class.new(config, options.merge(page: next_page)) if next_page?
        end

        def previous
          self.class.new(config, options.merge(page: previous_page)) if previous_page?
        end

        def all
          enumerator = Enumerator.new do |yielder|
            page = 1

            loop do
              response = self.class.new(config, options.merge(page: page))
              response.each { |item| yielder.yield item }

              raise StopIteration unless response.next_page?

              page = response.next_page
            end
          end

          enumerator.lazy
        end
      end
    end
  end
end
