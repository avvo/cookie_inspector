Rails.application.routes.draw do

  mount CookieInspector::Engine => "/cookie_inspector"
end
