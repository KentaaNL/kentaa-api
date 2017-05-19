module Kentaa
  module Api
    module Requests
      module All
        def all(options = {})
          enumerator = Enumerator.new do |yielder|
            page = 1

            loop do
              response = list(options.merge(page: page))
              response.each { |item| yielder.yield item } unless response.error?

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
