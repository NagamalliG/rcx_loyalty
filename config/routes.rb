Rails.application.routes.draw do
  root :to => 'home#index'
  #Proxy Controller..
  get 'proxy/index' => 'proxy#index'
  get 'proxy/redeem' => 'proxy#redeem'
  #Rest Controller
  get 'rest/getTierSvc'
  get 'rest/getPoints' => 'rest#getPoints', :defaults => { :format => 'json'},  :as => :get_points
  # root 'rest#getPoints'
  get 'rest/getProgramsSvc/' => 'rest#getProgramsSvc', :defaults => { :format => 'json'},  :as => :get_programs_svc
  get 'rest/getLevelsSvc/' => 'rest#getLevelsSvc', :defaults => { :format => 'json'},  :as => :get_levels_svc
  # get 'rest/getProgramsFromMeanApp'
  # root 'rest#getdata'
  
  post '/getPrograms' => 'home#getPrograms'
  get '/getTiers' => 'home#getTiers'
  post '/webhooks/carts_update' => 'webhooks#cartsUpdate', :defaults => { :format => 'json'},  :as => :carts_update
  post '/webhooks/product_create' => 'webhooks#productCreate', :defaults => { :format => 'json'},  :as => :product_create
  post '/webhooks/customers_create' => 'webhooks#customersCreate', :defaults => { :format => 'json'},  :as => :customers_create
  mount ShopifyApp::Engine, at: '/'
  # namespace :webhook do
  #   post ':type' => :productCreate
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
