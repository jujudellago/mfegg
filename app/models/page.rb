class Page < ActiveRecord::Base
  validates_presence_of :title
  validates_length_of :title, :within => 3..255
 # validates_length_of :body, :maximum => 10000
  acts_as_tree :order => "position"
  translates :title, :body, :description,  :keywords
  def before_create
    @attributes['permalink'] = 
      title.downcase.gsub(/\s+/, '_').gsub(/[^a-zA-Z0-9_]+/, '')
  end
  
  def to_param
    "#{id}-#{permalink}"
  end
  
 
end
