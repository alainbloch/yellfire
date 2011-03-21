class Message < ActiveRecord::Base
  
  attr_accessible :body, :what_to_do
  
  belongs_to :user
  belongs_to :recipient, :class_name => "User"
  
  validates_presence_of :user, :body, :what_to_do
  validates_length_of :body, :maximum => 140
  
  before_save :check_for_recipient
  
  after_create :yell_fire
    
private

  def check_for_recipient
    match = self.body.match(/^@([-\w\._]+)/)
    unless match.blank?
      # first match includes @. second match is just the name
      self.recipient = User.find_by_name(match[1])
    end
  end
  
  def yell_fire
    yell_yammer
    yell_email
    yell_cohuman
  end
  
  def yell_yammer
    yammer = user.access_tokens.find_by_service('yammer')
    if yammer
      concated_body = "Emergency:\n#{body}\n\nWhat To Do:\n#{what_to_do}"
      Yammer.post_message(yammer, concated_body)
    end    
  end
  
  def yell_email
    if self.user.mailing_list
      Broadcast.deliver_send_broadcast(self, self.user)
    end
  end
  
  def yell_cohuman
    access_token = user.access_tokens.find_by_service('cohuman')
    if access_token
      concated_body = "Emergency:\n#{body}\n\nWhat To Do:\n#{what_to_do}"
      Cohuman.yell_fire(access_token, concated_body)
    end
  end
  
end
