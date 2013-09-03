class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :feed
      t.string :title
      t.datetime :datetime
      t.string :url
      t.text :body

      t.timestamps
    end
  end
end
