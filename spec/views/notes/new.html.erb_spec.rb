require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/notes/new.html.erb" do
  include NotesHelper
  
  before(:each) do
    assigns[:note] = stub_model(Note,
      :new_record? => true,
      :title => "value for title",
      :body => "value for body"
    )
  end

  it "renders new note form" do
    render
    
    response.should have_tag("form[action=?][method=post]", notes_path) do
      with_tag("input#note_title[name=?]", "note[title]")
      with_tag("input#note_body[name=?]", "note[body]")
    end
  end
end


