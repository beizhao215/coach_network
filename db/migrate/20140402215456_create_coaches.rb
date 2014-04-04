class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :subject
      t.string :location
      t.string :self_introduction
      t.string :course_introduction

      t.timestamps
    end
  end
end
