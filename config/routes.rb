# config/routes.rb — définit toutes les routes HTTP de l'application EventFreeka

Rails.application.routes.draw do
  # Route racine : page d'accueil affichant la liste des événements
  root 'events#index'

  # Routes RESTful pour les utilisateurs (inscription, profil, édition, suppression)
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]

  # Routes RESTful complètes pour les événements
  # index   → liste des événements
  # show    → détail d'un événement
  # new     → formulaire de création
  # create  → enregistrement en base
  # edit    → formulaire d'édition (réservé au créateur)
  # update  → mise à jour en base
  # destroy → suppression (réservée au créateur)
  resources :events do
    # Routes imbriquées pour les participations (une participation appartient à un événement)
    resources :attendances, only: [:new, :create, :destroy]
  end

  # Route pour la page de connexion (session)
  get  '/login',  to: 'sessions#new',     as: :login
  post '/login',  to: 'sessions#create'

  # Route pour la déconnexion
  delete '/logout', to: 'sessions#destroy', as: :logout

  # Route de la page profil de l'utilisateur connecté
  get '/profile', to: 'users#profile', as: :profile
end
