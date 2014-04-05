class AddRememberTokenToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :remember_token, :string
    add_index :coaches, :remember_token
  end
end
