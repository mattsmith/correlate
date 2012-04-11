require 'spec_helper'

describe "interests/index" do
  before(:each) do
    assign(:interests, [
      stub_model(Interest),
      stub_model(Interest)
    ])
  end

  it "renders a list of interests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
