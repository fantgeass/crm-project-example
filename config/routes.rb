Spbec::Application.routes.draw do
  resources :attachment_job_types
  resources :attachment_categories
  resources :staff_roles
  resources :departments
  resources :positions
  resources :tasks
  resources :questions
  match 'attachments/content_types'
  resources :attachments do
    collection do
      get 'form'
    end
    member do
      get 'download'
    end
  end
  resources :companies
  resources :posts

  resources :tcps, :projects do
    member do
      put 'activate'
      put 'close'
      put 'complete'
      post 'create_project'
    end
    resources :staff
    resources :attachments do
      collection do
        get 'form'
      end
    end
    resources :comments
    resources :tasks do
      member do
        put 'complete'
        put 'open'
      end
      resources :comments
    end
    resources :questions do
      member do
        put 'complete'
        put 'open'
      end
      resources :comments
    end
  end

  devise_for :users, path: 'devise', controllers: {registrations: 'registrations'}
  match 'users/form'
  resources :users

  root to: 'home#index'
  get 'home/index'

end
