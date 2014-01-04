require 'spec_helper'

describe "recipients/show" do
  before(:each) do
    @recipient = assign(:recipient, stub_model(Recipient,
      :person_id => 1,
      :notification_id => 2,
      :uuid => "Uuid"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Uuid/)
  end
end
