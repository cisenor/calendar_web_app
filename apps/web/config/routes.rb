# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
root to: 'home#index'
get '/:year', to: 'home#index', as: :root
get '/dates', to: 'dates#index', as: :dates
get '/dates/add', to: 'dates#add', as: :add_date
post '/dates', to: 'dates#create', as: :create
post '/dates/create_occurrence',
     to: 'dates#create_occurrence',
     as: :create_occurrence
get '/dates/delete/:id', id: /\d+/, to: 'dates#delete'
get '/date/:year/:month/:day',
    year: /\d{4}/,
    month: /\d{1,2}/,
    day: /\d{1,2}/,
    to: 'date#display',
    as: :display_date
get '/session/new', to: 'session#new', as: :session_new
get '/auth/failure', to: 'session#failure', as: :session_fail
get '/auth/signout', to: 'session#destroy', as: :signout
get '/auth/:provider/callback', to: 'session#new'
