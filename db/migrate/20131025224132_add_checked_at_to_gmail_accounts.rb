class AddCheckedAtToGmailAccounts < ActiveRecord::Migration
  def change
    add_column :gmail_accounts, :checked_at, :datetime
  end
end
