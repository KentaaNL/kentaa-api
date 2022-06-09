# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Util do
  describe '.pluralize' do
    it 'returns the pluralized text' do
      expect(described_class.pluralize('donation')).to eq('donations')
    end

    context 'when a word ends with y' do
      it 'returns the pluralized text' do
        expect(described_class.pluralize('company')).to eq('companies')
      end
    end
  end
end
