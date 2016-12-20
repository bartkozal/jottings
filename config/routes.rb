Rails.application.routes.draw do
  namespace :editor do
    resource :profile, controller: "users", only: [:show, :update, :destroy]
    resource :trash, only: [:show, :destroy]
    resources :stacks, only: [:create, :update, :destroy] do
      scope module: :stacks do
        resource :share, controller: "collaborations", only: [:show, :create, :destroy]
        resource :ownership, only: :update
        resource :leave, only: :create
        resource :restore, only: [:create, :destroy]
      end
    end

    resources :documents, except: [:new, :edit] do
      scope module: :documents do
        resource :bookmark, only: [:create, :destroy]
        resource :move, only: :destroy do
          post ":id", to: "moves#create", as: ""
        end
        resource :restore, only: [:create, :destroy]
      end
    end

    get "/:page" => "static_pages#show", page: :page, as: :page
  end

  constraints Clearance::Constraints::SignedIn.new do
    root to: "editor/documents#index"
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "static_pages#show", page: "landing"
  end

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password, controller: "clearance/passwords", only: [:create, :edit, :update]
  end

  resource :feedback, only: [:create]

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  get "/:page" => "static_pages#show", page: :page, as: :page
end
