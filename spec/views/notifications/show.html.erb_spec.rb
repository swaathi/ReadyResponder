require 'spec_helper'

describe "notifications/show" do
  before(:each) do
    @notification = assign(:notification, stub_model(Notification,
      :event_id => 1,
      :author_id => 2,
      :status => "Status",
      :channels => "Channels",
      :subject => "Subject",
      :body => "Body",
      :comments => "MyText"
    ))
    @event = assign(:event, stub_model(Event,
      :id => 1,
      :title => 'A Big Event'
    ))
  end

  it "renders attributes in <p>" do
    pending 'I do not understand rspec view specs'
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Status/)
    rendered.should match(/Channels/)
    rendered.should match(/Subject/)
    rendered.should match(/Body/)
    rendered.should match(/MyText/)
  end
end
