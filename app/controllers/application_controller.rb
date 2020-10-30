class ApplicationController < ActionController::Base
  include SessionsHelper
  include GossipsHelper
  include CommentHelper
  include ApplicationHelper

  helper_method :current_user
  helper_method :logged_in?
end
