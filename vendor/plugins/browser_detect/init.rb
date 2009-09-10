require File.dirname(__FILE__) + "/lib/browser_detect_helper"
ActionView::Base.send(:include, BrowserDetectHelper)
