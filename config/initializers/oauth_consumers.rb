# edit this file to contain credentials for the OAuth services you support.
# each entry needs a corresponding token model.
#
# eg. :twitter => TwitterToken, :hour_feed => HourFeedToken etc.
#
# OAUTH_CREDENTIALS={
#   :twitter=>{
#     :key=>"",
#     :secret=>""
#   },
#   :google=>{
#     :key=>"",
#     :secret=>"",
#     :scope=>"" # see http://code.google.com/apis/gdata/faq.html#AuthScopes
#   },
#   :agree2=>{
#     :key=>"",
#     :secret=>""
#   },
#   :fireeagle=>{
#     :key=>"",
#     :secret=>""
#   },
#   :hour_feed=>{
#     :key=>"",
#     :secret=>"",
#     :options=>{ # OAuth::Consumer options
#       :site=>"http://hourfeed.com" # Remember to add a site for a generic OAuth site
#     }
#   },
#   :nu_bux=>{
#     :key=>"",
#     :secret=>"",
#     :super_class=>"OpenTransactToken",  # if a OAuth service follows a particular standard 
#                                         # with a token implementation you can set the superclass
#                                         # to use
#     :options=>{ # OAuth::Consumer options
#       :site=>"http://nubux.heroku.com" 
#     }
#   }
# }
# 

OAUTH_CREDENTIALS= {
 :twitter =>{
   :key    => "GiTznyGNxmVYUfFO0ocJTQ",
   :secret => "f0Kcmu0Xp7ytMq0DDrRbHOsYD9UhtRJI8Sal0foL8yU"
 },
 :facebook =>{
   :key     => "f96c044a9a2370e1c7ea6dc1ab21dda6",
   :secret  => "8b6f45d0f1bcb3524aa7da57e9cd4c74"
 },
 :yammer => {
   :key    => 'Flx8gK9IOpdex6CNjy742A',
   :secret => 'GccIlMVVqZGDsrZc4JIq0DGUqvF3oNyfymErWl8iyc'
 },
 :cohuman => {
   :key    => '4f1d386850d7f0d3296a7621af95c03dc524dabc',
   :secret => 'f9e8559aea955f87952688bc704da2ff4cdfcf59'
 }
}

OAUTH_CREDENTIALS={
} unless defined? OAUTH_CREDENTIALS

load 'oauth/models/consumers/service_loader.rb'