$ rails g monban:scaffold
       route  resources :users, only: [:new, :create]
       route  resource :session, only: [:new, :create, :destroy]
      create  app/views/users/new.html.erb
      create  app/views/sessions/new.html.erb
      create  app/controllers/sessions_controller.rb
      create  app/controllers/users_controller.rb
      insert  app/controllers/application_controller.rb
      create  app/models/user.rb
      create  db/migrate/20150720120736_create_users.rb
      create  config/locales/monban.en.yml

    Final Steps
    run:
      rake db:migrate
