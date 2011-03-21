class Broadcast < ActionMailer::Base

  def send_broadcast(message, user)
    recipients user.mailing_list
    from 'no-reply@example.com'
    bcc ["mkauffman@yammer-inc.com", "Broadcast watcher Watcher <watcher@example.com>"]
    subject 'Emergency Broadcast!!!!!!!!!!!!!'
    body :message => message
  end

end
