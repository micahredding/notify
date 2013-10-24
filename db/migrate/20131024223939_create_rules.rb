class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :name
      t.text :sender_regex
      t.text :subject_regex
      t.text :content_regex

      t.timestamps
    end
  end
end
