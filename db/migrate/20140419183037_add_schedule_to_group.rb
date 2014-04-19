class AddScheduleToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :schedule, :string
  end
end
