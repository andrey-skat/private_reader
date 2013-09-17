class RenameFeedIdToChannelIdInArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :feed_id, :channel_id
  end
end