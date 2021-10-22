# frozen_string_literal: true

module Kentaa
  module Api
    module Deprecation
      module_function

      def warn(message, callstack = caller)
        Kernel.warn("DEPRECATION WARNING: #{message} (called from #{callstack.first})")
      end
    end
  end
end
