class MessagesController < ApplicationController
  before_filter :login_required, :except => [:show]
  
  def create
    @message = current_user.messages.new(params[:message])
    
    # email to mailing list
    
    # broadcast to yammer
    
    # send to cohuman
    
    respond_to do |format|
      if @message.save
        message = "Your message has been sent!"
        format.html do
          flash[:success] = message
          redirect_to message_path(@message)
        end
        format.js{render(:update){|page| page.alert message}}
      else
        message = "An error has occurred."
        format.html do
          flash[:error] = message
        end
        format.js{render(:update){|page| page.alert message}}
      end
    end
  end
  
  def show
    
    @message = Message.find_by_id(params[:id])
    
    # respond_to do |format|
    #   
    # end    
  
  end
  
end
