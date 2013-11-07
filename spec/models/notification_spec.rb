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
    let(:event) { double :event, :name => "Some Big Event" }
    let(:notification) {Notification.new( :event => double( :event) ) }
    it "shows the name" do
      notification.event_name.should eg("Some Big Event")
    end
  end

  describe "callout" do
    #let(:notification) { Notification.new(subject: 'Test Callout', channels: ["email", "sms"]) }
#    let(:source_account)      { double :source_account, :decrease => nil }
 #   let(:destination_account) { double :destination_account, :increase => nil }
    #
    let(:notification) { double :notification, :subject => 'Testing Callout',
                                               :channels => ["email", "sms"],
                                               :body => "This is the body"}
    let(:reciepient) { double :person, :email => ["jdoe@example.com"]}
    let(:mail) { MessageMailer.callout(notification, reciepient) }

    it "renders the headers" do
      mail.subject.should eq("Testing Callout")
      mail.to.should eq(["jdoe@example.com"])
      mail.from.should eq(["callout@billericaema.org"])
    end
  end
end
