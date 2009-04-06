require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Note do

  def mock_note(stubs={})
    @mock_note ||= mock_model(Note, stubs)
  end

  before(:each) do
    @valid_attributes = {
      :title => "a valid title",
      :body => "a valid body"
    }
  end

  it "should create a new instance given valid attributes" do
    Note.create!(@valid_attributes)
  end

  it "should assign a default note title on new notes"do
    @new_note = Note.new
    @new_note.title.should == "Note #{Note.count + 1}"
  end
end
