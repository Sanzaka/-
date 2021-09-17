class RemoveOperationRightFromGroupMember < ActiveRecord::Migration[5.2]
  def change
    remove_column :group_members, :operation_right, :integer
  end
end
