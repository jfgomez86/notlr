class Note < ActiveRecord::Base
  include NoteResource
  validates_presence_of :body, :title
  validates_length_of :title, :within => 1..30, :on => :create, :message => "Title can contain a maximum of 30 characters."
  before_save :replace_links

  def initialize(*args)
    super(*args)
    self.title ||= "Note #{Note.count + 1}"
    self.status ||= "normal"
  end


  def to_xml(options = {})
    default_only = [:id, :body, :title]
    options[:only] = (options[:only] || []) + default_only
    super(options)
  end

end
