require 'spec_helper'

describe Person do

  before (:each) do
    @person = FactoryGirl.create(:person)
    @person.channels << FactoryGirl.build(:channel, category: "SMS", priority: "High")
  end

  it "has a valid factory" do
    FactoryGirl.create(:person).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:person, lastname: nil).should_not be_valid
  end

  it "returns an email address when asked nicely" do
    @person.channels.count.should eq(1)
    1.should eq(2)
  end

  it "always fails" do
    #1.should eq(2)
  end
end
