class ChangeFeedToChannel < ActiveRecord::Migration
  def change
    rename_table :feeds, :channels
  end
end
