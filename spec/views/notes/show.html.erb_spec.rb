require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/notes/show.html.erb" do
  include NotesHelper
  before(:each) do
    assigns[:note] = @note = stub_model(Note,
      :title => "value for title",
      :body => "value for body"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ body/)
  end
end

