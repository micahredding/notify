class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :gmail_account_id
      t.datetime :date
      t.text :subject
      t.string :sender
      t.text :body
      t.integer :uid

      t.timestamps
    end
  end
end
