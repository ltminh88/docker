Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper
end
