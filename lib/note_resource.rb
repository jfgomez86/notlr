module NoteResource
  #include Smileys
  REGEX_FOR = {
    :url => /^http:\/\/\S+$/
  }
  module ClassMethods
  end

  module InstanceMethods
    def replace_links
      self.body = self.body.split(" ").map do |s|
        s.gsub(REGEX_FOR[:url],
          "<a href='\\0' target='_blank' class='link'>Link &rarr;</a>" )
      end.join(" ")
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
