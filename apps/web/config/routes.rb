# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
root to: 'home#index', as: :home
get '/dates', to: 'dates#index', as: :dates
get '/dates/add', to: 'dates#add', as: :add_date
post '/dates', to: 'dates#create', as: :create
