Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "games#show"

  resource :game, only: [ :show, :new, :create ] do
    post :draw, on: :member
  end

  resources :bingo_cards, only: [ :create, :index ]
end
