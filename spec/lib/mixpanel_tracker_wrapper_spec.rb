# frozen_string_literal: true

require 'rails_helper'

describe MixpanelTrackerWrapper do
  describe '.from_request' do
    let(:distinct_id) { 'THISISMYDISTINCTID' }

    subject { MixpanelTrackerWrapper.from_request(mixpanel_trackable_request(distinct_id)) }

    it 'sets distinct_id from the request' do
      expect(subject.distinct_id).to eq(distinct_id)
    end
  end

  describe 'private #flatten_properties' do
    let(:hash) { { 'a' => { b: 'c', d: { 'e' => 1000 } } } }

    subject { MixpanelTrackerWrapper.flatten_properties(hash) }

    it 'returns the expected flattened version' do
      expect(subject)
        .to eq('a.b' => 'c', 'a.d.e' => 1000)
    end
  end
end
