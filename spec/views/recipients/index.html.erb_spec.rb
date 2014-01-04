require 'spec_helper'

describe "recipients/index" do
  before(:each) do
    assign(:recipients, [
      stub_model(Recipient,
        :person_id => 1,
        :notification_id => 2,
        :uuid => "Uuid"
      ),
      stub_model(Recipient,
        :person_id => 1,
        :notification_id => 2,
        :uuid => "Uuid"
      )
    ])
  end

  it "renders a list of recipients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Uuid".to_s, :count => 2
  end
end
