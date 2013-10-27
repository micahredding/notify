require 'spec_helper'

describe MailCheckSchedulerWorker do

  it "performs" do
    mail_check_scheduler = double
    MailCheckScheduler.stub(:new) { mail_check_scheduler }

    mail_check_scheduler.should_receive(:schedule_checks)

    MailCheckSchedulerWorker.new.perform
  end

end