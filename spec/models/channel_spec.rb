require 'spec_helper'

require_relative '../../app/models/channel'

describe Channel do

	subject { FactoryGirl.create(:channel) }
	let(:url) { 'http://example.com/' }

	describe '.subscribe' do
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
	end

	describe '#add_new_articles' do
		it 'adds only new articles' do
			entries = FeedEntryFactory.build_list(2)
			entries[0][:published] =  subject.last_updated - 1.day

			subject.add_new_articles(entries)

			expect(subject.articles.count).to eq 1
		end
	end
end