require 'spec_helper'

require_relative '../../app/models/channel'

describe Channel do
  it 'saves feed updates' do
    expect(Article).to receive(:add).once

    subject.add_new_articles([1])
  end
end