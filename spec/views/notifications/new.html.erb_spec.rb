require 'spec_helper'

describe "notifications/new" do
  before(:each) do
    assign(:notification, stub_model(Notification,
      :event_id => 1,
      :author_id => 1,
      :status => "MyString",
      :channels => "MyString",
      :subject => "MyString",
      :body => "MyString",
      :comments => "MyText"
    ).as_new_record)
    @event = assign(:event, stub_model(Event,
      :id => 1,
      :title => 'A Big Event'
    ))
  end

  it "renders new notification form" do
    render

    assert_select "form", :action => notifications_path, :method => "post" do
      assert_select "#notification_event_id", :name => "notification[event_id]"
      assert_select "#notification_channels", :name => "notification[channels]"
      assert_select "input#notification_subject", :name => "notification[subject]"
      assert_select "input#notification_body", :name => "notification[body]"
      assert_select "textarea#notification_comments", :name => "notification[comments]"
    end
  end
end
