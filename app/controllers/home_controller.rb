class HomeController < ApplicationController
  before_filter :login_required, :only => [:dashboard]
  
  
  def index
    # @messages = Message.find(:all, :limit => 20, :order => "created_at DESC")
    @message = Message.new
    respond_to do |format|
      format.html {}
      format.js {render @messages}
    end
  end
  
  def dashboard
    @user = current_user
    @message = Message.new
    @messages = current_user.feed.paginate(:page => params[:page], :order => "created_at DESC", :per_page => 20)     
    respond_to do |format|
      format.html {}
      format.js {render @messages}
    end
  end
  
end
