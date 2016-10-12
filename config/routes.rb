Rails.application.routes.draw do
  root to: "static_pages#show", page: "landing"
end
