class Cohuman
  
  def self.get_users(access_token)
    response = access_token.get('/users.json')
  end
  
  def self.get_consumer
    consumer = OAuth::Consumer.new(OAUTH_CREDENTIALS[:cohuman][:key], 
                                  OAUTH_CREDENTIALS[:cohuman][:secret],
                                  :site =>  OAUTH_CREDENTIALS[:cohuman][:options][:site],
                                  :request_token_path =>  OAUTH_CREDENTIALS[:cohuman][:options][:request_token_path],
                                  :authorize_path =>  OAUTH_CREDENTIALS[:cohuman][:options][:authorize_path],
                                  :access_token_path =>  OAUTH_CREDENTIALS[:cohuman][:options][:access_token_path],
                                  :http_method => :post)
  end
  
  def self.get_projects(access_token)
    response = access_token.get('/projects')
    projects = JSON.parse(response.body)['projects']['favorites']
    return projects    
  end
  
  def self.yell_fire(consumer_token, body)
    consumer = Cohuman.get_consumer
    access_token = OAuth::AccessToken.new(consumer, consumer_token.token, consumer_token.secret)
    projects = Cohuman.get_projects(access_token)
    projects.each do |project|
      Cohuman.post_message(access_token, project, body)
    end
  end
  
  def self.post_message(access_token, project, body)
    access_token.post('/task', {:project => project, :name => body}) rescue nil
  end
  
end