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
