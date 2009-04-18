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
  
  it "should be invalid without a title" do
    # When someone clears the title field    
    @new_note = Note.new(@valid_attributes.merge(:title => ""))
    @new_note.should_not be_valid
  end
  
  it "should be invalid without a body" do
    @new_note = Note.new(@valid_attributes.merge(:body => ""))
    @new_note.should_not be_valid    
  end
  
  it "should be invalid if its title contains more than 30 characters" do
    long_title = "really_long_title" * 5
    @new_note = Note.new(@valid_attributes.merge(:title => long_title))
    @new_note.should_not be_valid    
    @new_note.errors.on(:title).should == "Title can contain a maximum of 30 characters."
  end 

  it "should assign a default note title and status on new records"do
    @new_note = Note.new
    @new_note.title.should == "Note #{Note.count + 1}"
    @new_note.status.should == "normal"
  end
  
  it "should convert links into html hyperlinks" do
    link = "http://www.google.com"
    @new_note = Note.new(@valid_attributes.merge(:body => link))
    @new_note.save
    @new_note.body.should =~ /<a href=\'http:\/\/www.google.com\'/
  end

  it "should create a new instance given valid attributes" do
    Note.create!(@valid_attributes)
  end

end
