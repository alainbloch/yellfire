class Message < ActiveRecord::Base
  
  attr_accessible :body, :what_to_do
  
  belongs_to :user
  belongs_to :recipient, :class_name => "User"
  
  validates_presence_of :user, :body, :what_to_do
  validates_length_of :body, :maximum => 140
  
  before_save :check_for_recipient
    
private

  def check_for_recipient
    match = self.body.match(/^@([-\w\._]+)/)
    unless match.blank?
      # first match includes @. second match is just the name
      self.recipient = User.find_by_name(match[1])
    end
  end
  
end
