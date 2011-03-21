class YammerController < ApplicationController
  
  def auth
    oauth_verifier = params[:oauth_verifier]
    access_token = Yammer.get_access_token(session[:yammer_request_token], oauth_verifier)
    if access_token
      consumer_token = AccessToken.create(:user => current_user,
                                          :service => "yammer",
                                          :token   => access_token.token,
                                          :secret  => access_token.secret)      
      flash[:success] = "You have successfully accessed your Yammer account!"
      redirect_to root_path
    else
      reset_yammer_request_token
      flash[:error] = "Your Yammer access token was invalid. Please retry!"
      redirect_to edit_user_path(current_user)
    end
  rescue 
     reset_yammer_request_token
     flash[:error] = "Your Yammer access token was invalid. Please retry!"
     redirect_to edit_user_path(current_user)                            
  end

protected

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