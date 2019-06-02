Rails.application.routes.draw do
  get 'course_work/view'
  get 'course_work/cars'
  get 'course_work/watch'
  get 'course_work/l_customers'
  get 'course_work/customers'
  get 'course_work/brand_view'
  post 'handling/add_customers'
  post 'handling/edit'
  post 'handling/add_car'
  post 'handling/edit_car'
  post 'handling/edit_order'
  post 'handling/add_order'
  delete 'handling/del_customer'
  delete 'handling/del_car'
  delete 'handling/del_order'
  # get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  root 'course_work#view'
  resources :users, :except => [:new]
  resources :sessions 
  get '*unmatched_route', to: 'application#not_found'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
