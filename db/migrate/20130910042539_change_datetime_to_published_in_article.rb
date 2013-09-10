class ChangeDatetimeToPublishedInArticle < ActiveRecord::Migration
  def change
    rename_column :articles, :datetime, :published
  end
end
