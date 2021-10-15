class RemoveIsEmailReceiveFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :is_email_receive, :boolean
  end
end
