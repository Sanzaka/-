class AddDirectJoinToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :direct_join, :boolean, default: false, null: false
  end
end
