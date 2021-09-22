class AddGroupIdToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :results, :group_id, :integer
  end
end
