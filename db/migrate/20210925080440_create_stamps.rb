class CreateStamps < ActiveRecord::Migration[5.2]
  def change
    create_table :stamps do |t|
      t.integer :user_id, null: false
      t.integer :group_id, nill: false
      t.integer :message_id, null: false
      t.integer :choose_stamp, null: false

      t.timestamps
    end
  end
end
