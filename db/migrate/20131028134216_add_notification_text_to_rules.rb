class AddNotificationTextToRules < ActiveRecord::Migration
  def change
    add_column :rules, :notification_text, :text
  end
end
