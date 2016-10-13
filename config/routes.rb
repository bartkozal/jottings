Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: "editor/notes#new"
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "static_pages#show", page: "landing"
  end
end
