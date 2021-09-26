class RenameMessageIdColumnToStamps < ActiveRecord::Migration[5.2]
  def change
    rename_column :stamps, :message_id, :group_message_id
  end
end
