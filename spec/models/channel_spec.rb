require 'spec_helper'

require_relative '../../app/models/channel'

describe Channel do

	let(:url) { 'http://example.com/' }

	it 'subscribes to feed' do
		channel = {
				name: 'name_1',
				url: url,
				last_updated: Date.today,
				entries: []
		}
		expect(FeedFetcher).to receive(:discover).with(url).and_return(channel)

		described_class.subscribe(url)

		expect(described_class.count).to eq 1
	end

  it 'saves feed updates' do
    expect(Article).to receive(:add).once

    subject.add_new_articles([1])
  end
end