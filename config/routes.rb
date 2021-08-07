Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :states
      resources :cities
      resources :mayors, only: %i[index show create update destroy] do
        collection do
          get :is_male
          get :is_female
        end
      end
    end
  end
end
