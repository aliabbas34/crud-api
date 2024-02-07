class AddIndexToAuthors < ActiveRecord::Migration[7.0]
  def change
    add_index :authors, :email, unique:true #added index to table(PR change)
  end
end
