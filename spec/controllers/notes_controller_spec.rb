require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NotesController do

  def mock_note(stubs={})
    @mock_note ||= mock_model(Note, stubs)
  end
  
  describe "GET index" do

    it "exposes all notes as @notes" do
      Note.should_receive(:find).with(:all).and_return([mock_note])
      get :index
      assigns[:notes].should == [mock_note]
    end

    describe "with mime type of xml" do
  
      it "renders all notes as xml" do
        Note.should_receive(:find).with(:all).and_return(notes = mock("Array of Notes"))
        notes.should_receive(:to_xml).and_return("generated XML")
        get :index, :format => 'xml'
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "GET show" do

    it "exposes the requested note as @note" do
      Note.should_receive(:find).with("37").and_return(mock_note)
      get :show, :id => "37"
      assigns[:note].should equal(mock_note)
    end
    
    describe "with mime type of xml" do

      it "renders the requested note as xml" do
        Note.should_receive(:find).with("37").and_return(mock_note)
        mock_note.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37", :format => 'xml'
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "GET new" do
  
    it "exposes a new note as @note" do
      Note.should_receive(:new).and_return(mock_note)
      get :new
      assigns[:note].should equal(mock_note)
    end

  end

  describe "GET edit" do
  
    it "exposes the requested note as @note" do
      Note.should_receive(:find).with("37").and_return(mock_note)
      get :edit, :id => "37"
      assigns[:note].should equal(mock_note)
    end

  end

  describe "POST create" do

    describe "with valid params" do
      
      it "exposes a newly created note as @note" do
        Note.should_receive(:new).with({'these' => 'params'}).and_return(mock_note(:save => true))
        post :create, :note => {:these => 'params'}
        assigns(:note).should equal(mock_note)
      end

      it "redirects to the created note" do
        Note.stub!(:new).and_return(mock_note(:save => true))
        post :create, :note => {}
        response.should redirect_to(note_url(mock_note))
      end
      
    end
    
    describe "with invalid params" do

      it "exposes a newly created but unsaved note as @note" do
        Note.stub!(:new).with({'these' => 'params'}).and_return(mock_note(:save => false))
        post :create, :note => {:these => 'params'}
        assigns(:note).should equal(mock_note)
      end

      it "re-renders the 'new' template" do
        Note.stub!(:new).and_return(mock_note(:save => false))
        post :create, :note => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "PUT udpate" do

    describe "with valid params" do

      it "updates the requested note" do
        Note.should_receive(:find).with("37").and_return(mock_note)
        mock_note.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :note => {:these => 'params'}
      end

      it "exposes the requested note as @note" do
        Note.stub!(:find).and_return(mock_note(:update_attributes => true))
        put :update, :id => "1"
        assigns(:note).should equal(mock_note)
      end

      it "redirects to the note" do
        Note.stub!(:find).and_return(mock_note(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(note_url(mock_note))
      end

    end
    
    describe "with invalid params" do

      it "updates the requested note" do
        Note.should_receive(:find).with("37").and_return(mock_note)
        mock_note.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :note => {:these => 'params'}
      end

      it "exposes the note as @note" do
        Note.stub!(:find).and_return(mock_note(:update_attributes => false))
        put :update, :id => "1"
        assigns(:note).should equal(mock_note)
      end

      it "re-renders the 'edit' template" do
        Note.stub!(:find).and_return(mock_note(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "DELETE destroy" do

    it "destroys the requested note" do
      Note.should_receive(:find).with("37").and_return(mock_note)
      mock_note.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the notes list" do
      Note.stub!(:find).and_return(mock_note(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(notes_url)
    end

  end

end
