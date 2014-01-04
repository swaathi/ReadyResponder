require 'spec_helper'

describe "recipients/new" do
  before(:each) do
    assign(:recipient, stub_model(Recipient,
      :person_id => 1,
      :notification_id => 1,
      :uuid => "MyString"
    ).as_new_record)
  end

  it "renders new recipient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", recipients_path, "post" do
      assert_select "input#recipient_person_id[name=?]", "recipient[person_id]"
      assert_select "input#recipient_notification_id[name=?]", "recipient[notification_id]"
      assert_select "input#recipient_uuid[name=?]", "recipient[uuid]"
    end
  end
end
