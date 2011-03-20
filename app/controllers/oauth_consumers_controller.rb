require 'oauth/controllers/consumer_controller'
class OauthConsumersController < ApplicationController

  before_filter :login_required
  
  include Oauth::Controllers::ConsumerController
  
  def index
    set_yammer_request_token
    @consumer_tokens = current_user.consumer_tokens
  end
  
  protected
  
  # Change this to decide where you want to redirect user to after callback is finished.
  # params[:id] holds the service name so you could use this to redirect to various parts
  # of your application depending on what service you're connecting to.
  def go_back
    redirect_to root_url
  end
  
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
