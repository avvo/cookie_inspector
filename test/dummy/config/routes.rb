Rails.application.routes.draw do

  resource :home, only: [:index]

  root 'home#index'
  mount CookieInspector::Engine => "/cookie_inspector"
end
