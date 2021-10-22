# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Deprecation do
  describe '.warn' do
    it 'outputs a deprecation warning' do
      expect { described_class.warn("This method is deprecated") }.to output(/^DEPRECATION WARNING: This method is deprecated \(called from/).to_stderr
    end
  end
end
