class Note < ActiveRecord::Base
  validates_presence_of :body

  def initialize(*args)
    super *args
    self.title ||= "Note #{Note.count + 1}"
    self.status ||= "normal" 
  end
end
