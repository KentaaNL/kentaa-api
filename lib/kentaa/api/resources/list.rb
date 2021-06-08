# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class List < Base
        include Enumerable

        def [](index)
          resources[index]
        end

        def size
          resources.size
        end

        def each(&block)
          resources.each(&block)
        end

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
          self.class.new(config, options.merge(resource_class: resource_class, endpoint_path: endpoint_path, page: next_page)) if next_page?
        end

        def previous
          self.class.new(config, options.merge(resource_class: resource_class, endpoint_path: endpoint_path, page: previous_page)) if previous_page?
        end

        def all
          enumerator = Enumerator.new do |yielder|
            page = 1

            loop do
              response = self.class.new(config, options.merge(resource_class: resource_class, endpoint_path: endpoint_path, page: page))
              response.each { |item| yielder.yield item }

              raise StopIteration unless response.next_page?

              page = response.next_page
            end
          end

          enumerator.lazy
        end

        def get(id, options = {})
          resource = resource_class.new(config, id: id, options: options.merge(endpoint_path: endpoint_path))
          resource.load
        end

        def create(attributes, options = {})
          resource = resource_class.new(config, options: options.merge(endpoint_path: endpoint_path))
          resource.save(attributes)
        end

        def update(id, attributes, options = {})
          resource = resource_class.new(config, id: id, options: options.merge(endpoint_path: endpoint_path))
          resource.save(attributes)
        end

        def delete(id, options = {})
          resource = resource_class.new(config, id: id, options: options.merge(endpoint_path: endpoint_path))
          resource.delete
        end

        private

        def resources
          @resources ||= begin
            resources = []

            if data
              data.each do |resource|
                resources << resource_class.new(config, data: resource, options: options)
              end
            end

            resources
          end
        end

        def attribute_key
          Util.pluralize(resource_class.attribute_key)
        end

        def load_resource
          request.get(endpoint_path, options)
        end
      end
    end
  end
end
