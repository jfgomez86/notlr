require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/notes/edit.html.erb" do
  include NotesHelper
  
  before(:each) do
    assigns[:note] = @note = stub_model(Note,
      :new_record? => false,
      :title => "value for title",
      :body => "value for body"
    )
  end

  it "renders the edit note form" do
    render
    
    response.should have_tag("form[action=#{note_path(@note)}][method=post]") do
      with_tag('input#note_title[name=?]', "note[title]")
      with_tag('input#note_body[name=?]', "note[body]")
    end
  end
end


