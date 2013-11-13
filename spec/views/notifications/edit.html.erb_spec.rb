require 'spec_helper'

describe "notifications/edit" do
  before(:each) do
    @notification = assign(:notification, stub_model(Notification,
      :event_id => 1,
      :author_id => 1,
      :status => "MyString",
      :channels => "MyString",
      :subject => "MyString",
      :body => "MyString",
      :comments => "MyText"
    ))
  end

  it "renders the edit notification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notifications_path(@notification), :method => "post" do
      assert_select "#notification_event_id", :name => "notification[event_id]"
      assert_select "#notification_channels", :name => "notification[channels]"
      assert_select "input#notification_subject", :name => "notification[subject]"
      assert_select "input#notification_body", :name => "notification[body]"
      assert_select "textarea#notification_comments", :name => "notification[comments]"
    end
  end
end
