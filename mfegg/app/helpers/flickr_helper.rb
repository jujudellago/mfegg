module FlickrHelper

  require 'flickr'
  
  def flickr_link(photo)  
    if MY_CONFIG[:rflickr_lib]
      "http://www.flickr.com/photos/#{photo.owner_id}/#{photo.id}"
    else
      "http://www.flickr.com/photos/#{photo.owner.id}/#{photo.id}"
    end  
  end    
  
  def get_url(photo, size)
    if MY_CONFIG[:rflickr_lib]
      photo.url(size)
    else
      begin
        photo.source.gsub(/\....$/,"_#{size}.jpg")
      rescue 
        'error'
      end   
    end
  end
  
  def textile_flickr_link(photo, size_ch = 's')
    '!' + get_url(photo, size_ch) + '(' + photo.title + ')!:' + flickr_link(photo)
  end
  
  PHOTO_PREVIEW_SIZE = 's' if not defined? PHOTO_PREVIEW_SIZE
  PHOTO_INSERT_SIZE = 't' if not defined? PHOTO_INSERT_SIZE

  def photo_image_tag(photo)
    image_tag(get_url(photo, PHOTO_PREVIEW_SIZE),
       :alt => photo.title, 
       :title => photo.title,
       :id => textile_flickr_link(photo, PHOTO_INSERT_SIZE),
       :class => 'flickr_photo_square')
  end
  
  def flickr_photo_tag(photo)
    link_to(photo_image_tag(photo), flickr_link(photo))
  end
  
  def flickr_photo_draggable_tag(photo)
     photo_image_tag(photo) +
     draggable_element(textile_flickr_link(photo, PHOTO_INSERT_SIZE), :revert => true)
  end
  
end  