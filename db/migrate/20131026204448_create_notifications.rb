class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :gmail_account_id
      t.integer :email_id
      t.text :body
      t.boolean :read

      t.timestamps
    end
  end
end
