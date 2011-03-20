# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def set_yammer_request_token
    if session[:yammer_request_token]
      @yammer_request_token = session[:yammer_request_token]
    else
      reset_yammer_request_token
    end
  end
  
  def reset_yammer_request_token
    @yammer_request_token = session[:yammer_request_token] = Yammer.get_request_token
  end

end
