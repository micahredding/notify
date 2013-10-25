require 'spec_helper'

describe MailCheckWorker do

  it "performs" do
    id = 4
    mail_checker = double
    MailChecker.stub(:new).with(id) { mail_checker }

    mail_checker.should_receive(:check)

    MailCheckWorker.new.perform id
  end

end