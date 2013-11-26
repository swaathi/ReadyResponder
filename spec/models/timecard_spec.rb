require 'spec_helper'

describe Timecard do

  describe "creation" do
    let(:event)    {FactoryGirl.create(:event)}
    let(:person)   {FactoryGirl.create(:person)}
    let(:timecard) {FactoryGirl.build(:timecard, event: event, person: person)}

    it "has a valid factory" do
      timecard.stub(:person).and_return(person)
      timecard.stub(:event).and_return(event)
      timecard.should be_valid
    end

    it "requires an event" do
      @timecard = FactoryGirl.build(:timecard, event: nil)
      @timecard.should_not be_valid
    end

    it "requires a person" do
      @timecard = FactoryGirl.build(:timecard, person: nil)
      @timecard.should_not be_valid
    end

    it "requires an intended_end_time after intended_start_time" do
      @timecard = FactoryGirl.build(:timecard, intended_start_time: Time.current, intended_end_time: 2.minutes.ago)
      @timecard.should_not be_valid
    end
  end
  describe "calculations" do
    let(:event)    {FactoryGirl.create(:event)}
    let(:person)   {FactoryGirl.create(:person)}

    it "calculates an actual duration" do
      @timecard = FactoryGirl.create(:timecard,  event: event, person: person,
                                    actual_start_time: Time.current, actual_end_time: Time.current)
      @timecard.actual_duration.should eq(0)
      @timecard = FactoryGirl.create(:timecard,  event: event, person: person,
                                    actual_start_time: Time.current, actual_end_time: 75.minutes.from_now)
      @timecard.actual_duration.should eq(1.25)
    end

    it "calculates an intended duration" do
      @timecard = FactoryGirl.create(:timecard, event: event, person: person,
                                     intended_start_time: Time.current, intended_end_time: Time.current)
      @timecard.intended_duration.should eq(0)
      @timecard = FactoryGirl.create(:timecard, event: event, person: person,
                                     intended_start_time: Time.current, intended_end_time: 75.minutes.from_now)
      @timecard.intended_duration.should eq(1.25)
    end

    it "finds the existing timecard if it's a duplicate" do
      @original_timecard = FactoryGirl.create(:timecard, event: event, person: person,
                                              intended_start_time: Time.current, intention: "Available")
      @duplicate_timecard = FactoryGirl.build(:timecard, event: event, person: person,
                                              intended_start_time: Time.current, intention: "Available")
      @duplicate_timecard.find_duplicate_timecards.count.should eq(1)
      @duplicate_timecard = FactoryGirl.build(:timecard, event: event, person: person,
                                              actual_start_time: Time.current, outcome: "Worked")
      @duplicate_timecard.find_duplicate_timecards.count.should eq(1)
    end
  end
  describe "finders" do
    let(:event)    {FactoryGirl.create(:event)}
    let(:person)   {FactoryGirl.create(:person)}

    let (:unknown_timecard) {FactoryGirl.create(:timecard, event: event, person: person, intention: "Unknown")}
    let (:avail_timecard) {FactoryGirl.create(:timecard, event: event, person: person, intention: "Available")}
    let (:sched_timecard) {FactoryGirl.create(:timecard, event: event, person: person, intention: "Scheduled")}
    let (:working_timecard) {FactoryGirl.create(:timecard, event: event, person: person, intention: "Scheduled", outcome: "Working")}


    it "calculates the correct unknown people" do
      expect(unknown_timecard).to_not be_nil # This fires the lazy loading of the let block
      expect(Timecard.unknown.count).to eq(1)
      expect(Timecard.unknown.first).to eq(unknown_timecard)
    end

    it "calculates the correct scheduled people" do
      expect(avail_timecard).to_not be_nil # This fires the lazy loading of the let block
      expect(Timecard.available.count).to eq(1)
      expect(Timecard.available.first).to eq(avail_timecard)
    end

    it "calculates the correct scheduled people" do
      expect(sched_timecard).to_not be_nil # This fires the lazy loading of the let block
      expect(Timecard.scheduled.count).to eq(1)
      expect(Timecard.scheduled.first).to eq(sched_timecard)
    end
    it "always fails" do
   #  1.should eq(2)
    end
  end
end
