Rails.application.routes.draw do
  devise_for :users

  resources :task_relations
  resources :tasks
  post '/tasks/:id/close', to: 'tasks#close!', as: :close_task
  post '/task_relations/:id/favourite', to: 'task_relations#favourite!', as: :favourite_task_relation

  root to: "task_relations#index"
end
