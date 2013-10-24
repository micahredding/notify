class AddRefreshTokenToGmailAccounts < ActiveRecord::Migration
  def change
    add_column :gmail_accounts, :refresh_token, :string
  end
end
