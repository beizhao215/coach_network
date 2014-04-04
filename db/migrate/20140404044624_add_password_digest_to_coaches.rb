class AddPasswordDigestToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :password_digest, :string
  end
end
