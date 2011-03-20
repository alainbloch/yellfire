class Yammer  
  
  attr_writer :request_token
  
  YAMMER_CREDENTIALS = {
      :key    => 'Flx8gK9IOpdex6CNjy742A',
      :secret => 'GccIlMVVqZGDsrZc4JIq0DGUqvF3oNyfymErWl8iyc'
  }
  
  def self.get_consumer
    consumer = OAuth::Consumer.new(YAMMER_CREDENTIALS[:key], 
                                  YAMMER_CREDENTIALS[:secret],
                                  :site => "https://www.yammer.com",
                                  :request_token_path => "/oauth/request_token",
                                  :authorize_path => "/oauth/authorize",
                                  :access_token_path => "/oauth/access_token",
                                  :http_method => :post)
    return consumer
  end
    
  def self.get_request_token
    consumer = Yammer.get_consumer
    @request_token = consumer.get_request_token
    return @request_token
  end
  
  def self.get_access_token(request_token, oauth_verifier)
    access_token = request_token.get_access_token({:oauth_verifier => oauth_verifier})
    return access_token
  end
  
  def self.post_message(consumer_token, body)
    consumer = Yammer.get_consumer
    access_token = OAuth::AccessToken.new(consumer, consumer_token.token, consumer_token.secret)
    response = access_token.post('/api/v1/messages.json', {'body' => body})
    return response
  end
  
end