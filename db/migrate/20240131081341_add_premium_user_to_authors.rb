class AddPremiumUserToAuthors < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :premium_user, :boolean
  end
end
