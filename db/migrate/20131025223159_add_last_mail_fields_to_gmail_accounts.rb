class AddLastMailFieldsToGmailAccounts < ActiveRecord::Migration
  def change
    add_column :gmail_accounts, :last_mail_uid, :integer
    add_column :gmail_accounts, :last_mail_date, :datetime
  end
end
