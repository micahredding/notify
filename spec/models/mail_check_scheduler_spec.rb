require 'spec_helper'

describe MailCheckScheduler do

  let(:id1) { 4 }
  let(:id2) { 9 }
  let(:mail_check_scheduler) { MailCheckScheduler.new }
  let(:gmail_accounts) { [double(:id => id1), double(:id => id2)] }

  it 'schedules mail checks' do
    gmail_accounts.stub(:find_in_batches).and_yield(gmail_accounts)
    GmailAccount.stub(:overdue) {gmail_accounts}

    MailCheckWorker.should_receive(:perform_async).with(id1)
    MailCheckWorker.should_receive(:perform_async).with(id2)

    mail_check_scheduler.schedule_checks
  end
end