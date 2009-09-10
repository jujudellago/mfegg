class ApplicationController < ActionController::Base
  init_gettext "beast" if Object.const_defined?(:GetText)

  include ExceptionLoggable, BrowserFilters, AuthenticationSystem
  session :session_key => '_beast_session_id'

  helper_method :current_user, :logged_in?, :admin?, :last_active
  before_filter :login_by_token
  helper :transparent_message
#  helper :flickr
  before_filter :set_photos
  before_filter :set_locale 
  around_filter :set_language
  @inforum=false;
 

  def set_photos
    # @my_flickr ||= MyFlickr.new
    # @flickr_photos = @my_flickr.my_search(FLICKR_USER_ID,9)
  end
  
  def set_in_forum
     @inforum=true;
  end
  def set_not_forum
     @inforum=false;
  end
  def set_locale
     default_locale = 'fr-FR'
     request_language = request.env['HTTP_ACCEPT_LANGUAGE']
     request_language = request_language.nil? ? nil : request_language[/[^,;]+/]
     request_language = request_language.nil? ? nil : request_language[/[^-]+/]
     @locale = params[:locale] || session[:locale] || request_language || default_locale
     session[:locale] = @locale
     RAILS_DEFAULT_LOGGER.error("\n set_locale: session[:locale]=#{session[:locale]}  \n")
     begin
       Locale.set @locale
     rescue
       Locale.set default_locale
     end
   end
   
    def set_language
      RAILS_DEFAULT_LOGGER.error("\n set_language: session[:locale]=#{session[:locale]}  \n")
        Gibberish.use_language(session[:locale]) { yield }
        # Gibberish.use_language(DEFAULT_LANGUAGE) { yield }
      end


  protected
    def last_active
      session[:last_active] ||= Time.now.utc
    end
    
    def rescue_action(exception)
      exception.is_a?(ActiveRecord::RecordInvalid) ? render_invalid_record(exception.record) : super
    end

    def render_invalid_record(record)
      render :action => (record.new_record? ? 'new' : 'edit')
    end
end
