require 'spec_helper'

describe "notifications/index" do
  before(:each) do
    assign(:notifications, [
      stub_model(Notification,
        :event_id => 1,
        :author_id => 2,
        :status => "Status",
        :channels => "Channels",
        :subject => "Subject",
        :body => "Body",
        :comments => "MyText"
      ),
      stub_model(Notification,
        :event_id => 1,
        :author_id => 2,
        :status => "Status",
        :channels => "Channels",
        :subject => "Subject",
        :body => "Body",
        :comments => "MyText"
      )
    ])
  end

  it "renders a list of notifications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
  end
end
