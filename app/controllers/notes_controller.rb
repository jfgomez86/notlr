class NotesController < ApplicationController
  # GET /notes
  # GET /notes.xml
  def index
    @notes = Note.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = Note.new

    respond_to do |format|
      format.js { render :partial => 'new' }
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = Note.new(params[:note])

    respond_to do |format|
      if @note.save
        format.html { redirect_to(notes_path) }
        format.js 
        format.xml  { render :xml => @note, :status => :created, :location => @note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
        format.js  do
          render :js => "alert('Note needs Title (30 characters max!) AND Body.\\nWill not save if one is mising.'); $('note_submit').enable(); $('form_spinner').fade({duration: 0.3})"
        end
      end
    end
  end


  def edit
    @note = Note.find(params[:id])

    respond_to do |format|
      format.js { render :partial => 'edit' }
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to(notes_path) }
        format.js do
          response.content_type = "application/json"
          render :js => @note.to_json(:only => [:title, :body, :left, :top])
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = Note.find(params[:id])
    @note.deleted_at = DateTime.now
    @note.save
    respond_to do |format|
      format.html { redirect_to(notes_url) }
      format.js { head :ok }
    end
  end
end
