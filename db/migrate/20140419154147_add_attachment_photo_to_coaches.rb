class AddAttachmentPhotoToCoaches < ActiveRecord::Migration
  def self.up
    change_table :coaches do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :coaches, :photo
  end
end
