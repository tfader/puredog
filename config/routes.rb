Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  root 'welcome#index'

  resources :employees do
    resources :employee_users
    resources :employee_spots
  end

  resources :spots

  resources :patient_attrs

  resources :patients do
    resources :attrs do
      resources :patient_attr_values
    end
  end

  resources :attr_classes do
    resources :attrs
  end

  resources :materials

  resources :varieties

  resources :exams

end
