class Broadcast < ActionMailer::Base
  
  default :from => 'no-reply@example.com',
          :return_path => 'system@example.com'

  def send(message, user)
    @message = message
    mail(:to => user.mailing_list,
         :bcc => ["mkauffman@yammer-inc.com", "Broadcast watcher Watcher <watcher@example.com>"],
         :subject => 'Emergency Broadcast!!!!!!!!!!!!!')
    end
  end


end
