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
    get :autocomplete_patient_name, on: :collection
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
    get :autocomplete_exam_name, on: :collection
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

  resources :clients do
    get :autocomplete_client_name, on: :collection
  end

  resources :cities do
    get :autocomplete_city_name, on: :collection
  end

  resources :orders do
    resources :order_items
  end

  resources :order_statuses do
    get :autocomplete_order_status_name, on: :collection
  end

  resources :order_flows

  resources :session_order_items do
    patch :add_item
  end

end
