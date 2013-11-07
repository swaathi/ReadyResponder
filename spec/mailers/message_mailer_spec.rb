require "spec_helper"

describe MessageMailer do
  describe "callout" do
    #let(:notification) { Notification.new(subject: 'Test Callout', channels: ["email", "sms"]) }
#    let(:source_account)      { double :source_account, :decrease => nil }
 #   let(:destination_account) { double :destination_account, :increase => nil }
    #
    let(:notification) { double :notification, :subject => 'Testing Callout', :channels => ["email", "sms"], :body => "This is the body"}
    let(:reciepient) { double :person, :email => ["jdoe@example.com"]}
    let(:mail) { MessageMailer.callout(notification, reciepient) }

    it "renders the headers" do
      mail.subject.should eq("Testing Callout")
      mail.to.should eq(["jdoe@example.com"])
      mail.from.should eq(["callout@billericaema.org"])
    end

    it "renders the body" do
      mail.body.encoded.should match(notification.body)
    end
  end

end
