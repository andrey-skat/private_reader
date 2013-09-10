require 'spec_helper'

require_relative '../../app/models/feed'

describe Feed do
  it 'saves feed updates' do
    expect(Article).to receive(:add).once

    subject.add_new_articles([1])
  end
end