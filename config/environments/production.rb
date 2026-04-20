# config/environments/production.rb — paramètres spécifiques à l'environnement de production (Heroku)

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Désactive le rechargement du code (le code est chargé une seule fois au démarrage)
  config.enable_reloading = false

  # Ne pas afficher les erreurs détaillées aux visiteurs (sécurité)
  config.consider_all_requests_local = false

  # Active le cache des actions de controller pour de meilleures performances
  config.action_controller.perform_caching = true

  # Force l'utilisation du protocole HTTPS (sécurité absolue en production)
  config.force_ssl = true

  # Niveau de logs minimal en production (info = requêtes HTTP et messages importants uniquement)
  config.log_level = :info

  # Utilise le format de log structuré (JSON-compatible) pour une meilleure lisibilité dans Heroku Logs
  config.log_tags = [:request_id]

  # Stocke le cache côté serveur (mémoire Heroku dyno — remplacer par Redis si multi-dyno)
  config.cache_store = :memory_store

  # Précompile les assets pour de meilleures performances (CSS, JS, images)
  config.assets.compile = false

  # ===== CONFIGURATION ACTION MAILER EN PRODUCTION =====

  # Utilise le protocole SMTP pour envoyer de vrais emails via SendGrid
  config.action_mailer.delivery_method = :smtp

  # Active l'envoi réel d'emails en production
  config.action_mailer.perform_deliveries = true

  # Lève une exception si un email ne peut pas être envoyé (détection des erreurs SMTP)
  config.action_mailer.raise_delivery_errors = true

  # URL de base utilisée dans les liens générés dans les emails (domaine de production)
  config.action_mailer.default_url_options = { host: 'eventfreeka.com', protocol: 'https' }

  # ===== FIN CONFIGURATION ACTION MAILER =====

  # Active la journalisation des requêtes SQL lentes (> 0.5 secondes)
  # config.active_record.slow_query_threshold = 0.5

  # Désactive les annotations de fichiers source dans les vues (inutile en production)
  config.action_view.annotate_rendered_view_with_filenames = false
end
