require 'spec_helper'

describe Notification do
  describe "validation" do
    let(:notification) { Notification.new( :subject => 'Testing Callout',
                                           :body => "This is the body")}
    it "has working validation" do
      notification.should_not be_valid
    end
  end

  describe "displays helpers" do
    let(:an_event) { Event.new( :title => "Some Big Event")}
    let(:notification) {Notification.new}
    it "shows the title" do
      notification.stub(:event).and_return(an_event)
      notification.event_title.should eq("Some Big Event")
    end
  end

  describe "callout" do
    #TODO This test may need to be moved to the message tests
    #let(:notification) { Notification.new(subject: 'Test Callout', channels: ["email", "sms"]) }
#    let(:source_account)      { double :source_account, :decrease => nil }
 #   let(:destination_account) { double :destination_account, :increase => nil }
    #
    let(:notification) { double :notification, :subject => 'Testing Callout',
                                               :channels => ["email", "sms"],
                                               :body => "This is the body"}
    let(:reciepient) { double :person, :email => ["jdoe@example.com"]}
    let(:mail) { MessageMailer.callout(notification, reciepient.email) }

    it "renders the headers" do
      mail.subject.should eq("Testing Callout")
      mail.to.should eq(["jdoe@example.com"])
      mail.from.should eq(["records@billericaema.org"])
    end
  end
end
