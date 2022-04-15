# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Util do
  describe '.pluralize' do
    it 'returns the pluralized text' do
      expect(described_class.pluralize('donation')).to eq('donations')
    end
  end
end
