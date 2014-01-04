require 'spec_helper'

describe "responses/edit" do
  before(:each) do
    @response = assign(:response, stub_model(Response,
      :recipient_id => 1,
      :intention => "MyString",
      :duration => "",
      :duration => "",
      :channel => "MyString"
    ))
  end

  it "renders the edit response form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", response_path(@response), "post" do
      assert_select "input#response_recipient_id[name=?]", "response[recipient_id]"
      assert_select "input#response_intention[name=?]", "response[intention]"
      assert_select "input#response_duration[name=?]", "response[duration]"
      assert_select "input#response_duration[name=?]", "response[duration]"
      assert_select "input#response_channel[name=?]", "response[channel]"
    end
  end
end
