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
    let(:event) { double :event, :title=> "Some Big Event" }
    let(:notification) { Notification.new }
    it "shows the name" do
      notification.stub(:event).and_return(event)
      notification.event_title.should eq("Some Big Event")
    end
  end

  describe "notify" do
    let(:notification) { FactoryGirl.build( :notification, :subject => 'Testing Callout',
                                               :channels => ["email", "sms"],
                                               :body => "This is the body") }
    let(:receipient1) { FactoryGirl.build(:person) }
    let(:receipient2) { FactoryGirl.build(:person) }
    let(:event) { FactoryGirl.build(:event) }
    it "collects the correct people to notify" do
      notification.should_receive(:event_groups).and_return(['Available', 'Unknown'])
      notification.should_receive(:event).and_return(event)
      event.should_receive(:roster).with('Available').and_return([receipient1])
      event.should_receive(:roster).with('Unknown').and_return([receipient2])
      notification.notify
    end
    it "calls the mailer for email channels" do
      pending "This is too complicated"
      event.should_receive(:scheduled_people).and_return([receipient])
      receipient.should_receive(:email).and_return(['jdoe@example.com','john@example.com'])
      MessageMailer.any_instance.should_receive(:callout)
      notification.should_receive(:event).and_return(event)
      notification.notify
    end
  end
end
