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

  resources :varieties do
    get :autocomplete_variety_name, on: :collection
  end

  resources :exams do
    resources :exam_varieties
    resources :exam_units
  end

  resources :exam_attrs

  resources :exam_groups

  resources :units do
    resources :unit_rates
  end

  resources :patrons do
    get :autocomplete_patron_name, on: :collection
  end

end
