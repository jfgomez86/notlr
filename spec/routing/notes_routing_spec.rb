require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NotesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "notes", :action => "index").should == "/notes"
    end
  
    it "maps #new" do
      route_for(:controller => "notes", :action => "new").should == "/notes/new"
    end
  
    it "maps #show" do
      route_for(:controller => "notes", :action => "show", :id => "1").should == "/notes/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "notes", :action => "edit", :id => "1").should == "/notes/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "notes", :action => "create").should == {:path => "/notes", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "notes", :action => "update", :id => "1").should == {:path =>"/notes/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "notes", :action => "destroy", :id => "1").should == {:path =>"/notes/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/notes").should == {:controller => "notes", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/notes/new").should == {:controller => "notes", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/notes").should == {:controller => "notes", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/notes/1").should == {:controller => "notes", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/notes/1/edit").should == {:controller => "notes", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/notes/1").should == {:controller => "notes", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/notes/1").should == {:controller => "notes", :action => "destroy", :id => "1"}
    end
  end
end
