require 'spec_helper'

describe "interests/edit" do
  before(:each) do
    @interest = assign(:interest, stub_model(Interest))
  end

  it "renders the edit interest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => interests_path(@interest), :method => "post" do
    end
  end
end
