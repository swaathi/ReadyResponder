require 'spec_helper'

describe "responses/new" do
  before(:each) do
    assign(:response, stub_model(Response,
      :recipient_id => 1,
      :intention => "MyString",
      :duration => "",
      :duration => "",
      :channel => "MyString"
    ).as_new_record)
  end

  it "renders new response form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", responses_path, "post" do
      assert_select "input#response_recipient_id[name=?]", "response[recipient_id]"
      assert_select "input#response_intention[name=?]", "response[intention]"
      assert_select "input#response_duration[name=?]", "response[duration]"
      assert_select "input#response_duration[name=?]", "response[duration]"
      assert_select "input#response_channel[name=?]", "response[channel]"
    end
  end
end
