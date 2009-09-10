require 'md5'

module ApplicationHelper
  def submit_tag(value = "Save Changes"[], options={} )
    or_option = options.delete(:or)
    return super + "<span class='button_or'>"+"or"[]+" " + or_option + "</span>" if or_option
    super
  end

  def ajax_spinner_for(id, spinner="spinner.gif")
    "<img src='/images/#{spinner}' style='display:none; vertical-align:middle;' id='#{id.to_s}_spinner' /> "
  end

  def avatar_for(user, size=32)
    image_tag "http://www.gravatar.com/avatar.php?gravatar_id=#{MD5.md5(user.email)}&rating=PG&size=#{size}", :size => "#{size}x#{size}", :class => 'photo'
  end

  def feed_icon_tag(title, url)
    (@feed_icons ||= []) << { :url => url, :title => title }
    link_to image_tag('feed-icon.png', :size => '14x14', :alt => "Subscribe to #{title}"), url
  end

  def search_posts_title
    returning(params[:q].blank? ? 'Recent Posts'[] : "Searching for"[] + " '#{h params[:q]}'") do |title|
      title << " "+'by {user}'[:by_user,h(User.find(params[:user_id]).display_name)] if params[:user_id]
      title << " "+'in {forum}'[:in_forum,h(Forum.find(params[:forum_id]).name)] if params[:forum_id]
    end
  end
    
  def light_photo(photo,reflect=true)
    displayed=display_photo(photo,reflect)
    return lightbox_link_to(displayed,  photo.public_filename,nil ,  {:rel => "lightbox[myalbum]", :title=>photo.name+"<br /><i>"+photo.legend,:legend=>"link legend"}) 
  end

  def display_photo(photo,reflect=true)
    if reflect 
      return image_tag(photo.public_filename(:thumb),:class=>'reflect ropacity25',:alt=>photo.name,:border=>'0',:onmouseover=>"Reflection.add(this, { opacity: 3/4 });", :onmouseout=>"Reflection.add(this, { opacity: 1/4 });")  
    else
      return image_tag(photo.public_filename(:thumb),:alt=>photo.name,:title=>photo.name,:legend=>photo.legend,:border=>'0')  
    end
  end
  def topic_title_link(topic, options)
    if topic.title =~ /^\[([^\]]{1,15})\]((\s+)\w+.*)/
      "<span class='flag'>#{$1}</span>" + 
      link_to(h($2.strip), topic_path(@forum, topic), options)
    else
      link_to(h(topic.title), topic_path(@forum, topic), options)
    end
  end

  def search_posts_path(rss = false)
    options = params[:q].blank? ? {} : {:q => params[:q]}
    prefix = rss ? 'formatted_' : ''
    options[:format] = 'rss' if rss
    [[:user, :user_id], [:forum, :forum_id]].each do |(route_key, param_key)|
      return send("#{prefix}#{route_key}_posts_path", options.update(param_key => params[param_key])) if params[param_key]
    end
    options[:q] ? all_search_posts_path(options) : send("#{prefix}all_posts_path", options)
  end

  # on windows and this isn't working like you expect?
  # check: http://beast.caboo.se/forums/1/topics/657
  # strftime on windows doesn't seem to support %e and you'll need to 
  # use the less cool %d in the strftime line below
  def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)
    distance_in_minutes = (((to_time - from_time).abs)/60).round

    case distance_in_minutes
    when 0..1           then (distance_in_minutes==0) ? 'a few seconds ago'[] : '1 minute ago'[]
    when 2..59          then "{minutes} minutes ago"[:minutes_ago, distance_in_minutes]
    when 60..90         then "1 hour ago"[]
    when 90..1440       then "{hours} hours ago"[:hours_ago, (distance_in_minutes.to_f / 60.0).round]
    when 1440..2160     then '1 day ago'[] # 1 day to 1.5 days
    when 2160..2880     then "{days} days ago"[:days_ago, (distance_in_minutes.to_f / 1440.0).round] # 1.5 days to 2 days
    else from_time.strftime("%b %e, %Y  %l:%M%p"[:datetime_format]).gsub(/([AP]M)/) { |x| x.downcase }
    end
  end

  def age(birthdate)
    today = Date.today
    return nil if birthdate.nil? || birthdate > today
    if (today.month > birthdate.month) or 
      (today.month == birthdate.month and today.day >= birthdate.day)
      # Birthday has happened already this year.
      today.year - birthdate.year
    else
      today.year - birthdate.year - 1
    end
  end
 
 
  def js_open
    '<script type="text/javascript">//<![CDATA[' + "\n"
  end
  
  def js_close
    "\n" + '//]]>' + "</script>"
  end
 
 
    def use_tinymce(theme="advanced")



      if theme=="advanced"
      string = <<END_OF_STRING
      tinyMCE.init({
      	mode : "textareas",
      	editor_selector : "tiny_mce",
      	theme : "advanced",
      	language : "fr",
      	plugins : "inlinepopups,ts_advimage,advlink,emotions,iespell,zoom,searchreplace,fullscreen,visualchars,youtube,table,contextmenu",
      	theme_advanced_buttons1 : "undo,redo,removeformat,|,formatselect,|,bold,italic,underline,strikethrough,sub,sup,|,outdent,indent,bullist,numlist,hr",
      	theme_advanced_buttons2 : "backcolor,|,link,unlink,charmap,emotions,ts_image,youtube,iespell,|,search,replace,|,cleanup,code,fullscreen,help",
      	theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup",
      	theme_advanced_toolbar_location : "top",
      	theme_advanced_toolbar_align : "left",
      	theme_advanced_path_location : "bottom",
      	theme_advanced_blockformats : "p,h1,h2,h3,h4,blockquote",
      	gecko_spellcheck : true,
      	extended_valid_elements : "a[name|href|target|title|onclick],img[class|src|style|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name],hr[class|width|size|noshade],span[class|align|style],font[]",
      	theme_advanced_resizing : true,
      	theme_advanced_resize_horizontal : false
      });
END_OF_STRING
else
     string = <<END_OF_STRING
      tinyMCE.init({
      	mode : "textareas",
      	editor_selector : "tiny_mce",
      	theme : "simple",
      	plugins : "inlinepopups,ts_advimage,advlink,emotions,iespell,zoom,searchreplace,fullscreen,visualchars,youtube,table",
      	theme_advanced_buttons1 : "undo,redo,removeformat,|,formatselect,|,bold,italic,underline,strikethrough,sub,sup,|,outdent,indent,bullist,numlist,hr",
      	theme_advanced_buttons2 : "backcolor,|,link,unlink,charmap,emotions,ts_image,youtube,iespell,|,search,replace,|,cleanup,code,fullscreen,help",
      	theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup",
      	theme_advanced_toolbar_location : "top",
      	theme_advanced_toolbar_align : "left",
      	theme_advanced_path_location : "bottom",
      	theme_advanced_blockformats : "p,h1,h2,h3,h4,blockquote",
      	gecko_spellcheck : true,
      	extended_valid_elements : "a[name|href|target|title|onclick],img[class|src|style|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name],hr[class|width|size|noshade],span[class|align|style],font[]",
      	theme_advanced_resizing : true,
      	theme_advanced_resize_horizontal : false
      });
END_OF_STRING
  end

      js_open + string + js_close
    end

    def split_title(title)
      displayed_title=""
      unless title.blank?
        displayed_title=""
        title_array=title.split
        i=0
        title_array.each do |t|
          if (i==0)
            displayed_title << "<span>"+t+" </span>"
          else
            displayed_title << t+" "
          end
          i+=1
        end
      end
      return displayed_title
    end
 
 
 
 
end
