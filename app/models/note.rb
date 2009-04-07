class Note < ActiveRecord::Base
  include NoteResource
  validates_presence_of :body, :title
  before_save :replace_links

  def initialize(*args)
    super *args
    self.title ||= "Note #{Note.count + 1}"
    self.status ||= "normal" 
  end

end
