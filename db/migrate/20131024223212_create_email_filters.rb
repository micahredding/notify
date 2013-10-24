class CreateEmailFilters < ActiveRecord::Migration
  def change
    create_table :email_filters do |t|
      t.integer :rule_id
      t.integer :user_id

      t.timestamps
    end
  end
end
