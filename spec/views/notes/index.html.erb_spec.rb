require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/notes/index.html.erb" do
  include NotesHelper
  
  before(:each) do
    assigns[:notes] = [
      stub_model(Note,
        :title => "value for title",
        :body => "value for body"
      ),
      stub_model(Note,
        :title => "value for title",
        :body => "value for body"
      )
    ]
  end

  it "renders a list of notes" do
    render
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", "value for body".to_s, 2)
  end
end

