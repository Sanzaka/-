class AddOperationRightToGroupMember < ActiveRecord::Migration[5.2]
  def change
    add_column :group_members, :operation_right, :integer, null: false, default: 0
  end
end
