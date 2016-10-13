Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: "editor/notes#new"

    namespace :editor do
      resources :notes, except: :index
    end
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "static_pages#show", page: "landing"
  end
end
