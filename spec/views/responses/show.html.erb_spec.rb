require 'spec_helper'

describe "responses/show" do
  before(:each) do
    @response = assign(:response, stub_model(Response,
      :recipient_id => 1,
      :intention => "Intention",
      :duration => "",
      :duration => "",
      :channel => "Channel"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Intention/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Channel/)
  end
end
