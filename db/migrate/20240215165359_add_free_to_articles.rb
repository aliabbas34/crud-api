class AddFreeToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :free, :boolean
  end
end
