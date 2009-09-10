class Image < ActiveRecord::Base
  belongs_to :page
  
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :max_size => 5.megabytes,
                 :resize_to => '800x600>',
                 :processor => :Rmagick,
                 :thumbnails => { :thumb => '150x150>' }
  validates_as_attachment
  
end
