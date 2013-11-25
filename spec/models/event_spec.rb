require 'spec_helper'

describe Event do
  it "has a valid factory" do
    FactoryGirl.build(:event).should be_valid
  end
  it "is invalid without a title" do
    FactoryGirl.build(:event, title: nil).should_not be_valid
  end

  describe "returns" do
    let(:an_event)  { FactoryGirl.create(:event, :title => "Some Big Event")}
    let(:person1)   { FactoryGirl.create(:person )}
    let(:person2)   { FactoryGirl.create(:person )}
    let(:timecard1) { FactoryGirl.create(:timecard, event: an_event, person: person1, intention: 'Unknown')}
    let(:timecard2) { FactoryGirl.create(:timecard, event: an_event, person: person2, intention: 'Unknown')}
    it "a roster"  do
      timecard1.event.should eq(an_event)
      timecard2.event.should eq(an_event)
      an_event.timecards.count.should eq(2)
      an_event.roster('Unknown').should eq([person1, person2])
    end
  end

  it "is invalid if end date is before start date" do
    FactoryGirl.build(:event, start_time: Time.current, end_time: 10.days.ago).should_not be_valid
  end

  it "is invalid if start_time is blank and status is completed" do
    FactoryGirl.build(:event, status: "Completed", start_time: nil, end_time: 10.days.ago ).should_not be_valid
  end
  it "is invalid if end_time is blank and status is completed" do
    FactoryGirl.build(:event, status: "Completed", start_time: Time.current, end_time: nil).should_not be_valid
  end

  it "returns a correct manhours count" do
    @person1 = FactoryGirl.create(:person)
    @person2 = FactoryGirl.create(:person)
    @event = FactoryGirl.create(:event)
    @timecard1 = FactoryGirl.create(:timecard, event: @event, person: @person1,
                                    actual_start_time: Time.current, actual_end_time: 75.minutes.from_now)
    @timecard2 = FactoryGirl.create(:timecard, event: @event, person: @person2,
                                    actual_start_time: Time.current, actual_end_time: 60.minutes.from_now)
    @event.timecards.count.should equal(2)
    @event.manhours.should eq(2.25)
  end

  it "creates an available timecard with actual times brought in from the event" do
    @person = FactoryGirl.create(:person)
    @event = FactoryGirl.create(:event, start_time: Time.current, end_time: 75.minutes.from_now, status: "Scheduled")
    @timecard = @event.schedule(@person, "Available")
    @timecard.class.name.should eq("Timecard")
    @timecard.intention.should eq("Available")
    @timecard.intended_start_time.should eq(@event.start_time)
    @timecard.intended_end_time.should eq(@event.end_time)
  end

  it "reports if it's ready to schedule" do
    @event = FactoryGirl.build(:event, start_time: nil, end_time: 75.minutes.from_now, status: "Scheduled")
    @event.ready_to_schedule?("Available").should eq(false)  #Need a start time
    @event = FactoryGirl.build(:event, start_time: Time.current, end_time: nil, status: "Scheduled")
    @event.ready_to_schedule?("Worked").should eq(false)  #Need an end time
    @event = FactoryGirl.build(:event, start_time: Time.current, end_time: 75.minutes.from_now, status: "Closed")
    @event.ready_to_schedule?("Scheduled").should eq(false)  #Never for a closed event
    @event = FactoryGirl.build(:event, start_time: Time.current, end_time: 75.minutes.from_now, status: "Scheduled")
    @event.ready_to_schedule?("Scheduled").should eq(true) # Happy path
  end

  it "always fails" do
    #1.should eq(2)
  end
end
