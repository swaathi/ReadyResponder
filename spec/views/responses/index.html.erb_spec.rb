require 'spec_helper'

describe "responses/index" do
  before(:each) do
    assign(:responses, [
      stub_model(Response,
        :recipient_id => 1,
        :intention => "Available",
        :duration => "",
        :channel => "SMS"
      ),
      stub_model(Response,
        :recipient_id => 1,
        :intention => "Scheduled",
        :duration => "",
        :channel => "SMS"
      )
    ])
  end

  it "renders a list of responses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Available".to_s, :count => 1
    assert_select "tr>td", :text => "SMS".to_s, :count => 2
  end
end
