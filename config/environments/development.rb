# config/environments/development.rb — paramètres spécifiques à l'environnement de développement

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Active le rechargement du code à chaque requête (évite de redémarrer le serveur)
  config.enable_reloading = true

  # Lève une exception si un asset est manquant (détection rapide des erreurs)
  config.assets.raise_runtime_errors = true

  # Affiche les erreurs détaillées directement dans le navigateur
  config.consider_all_requests_local = true

  # Active les outils de développement dans la console du navigateur (Web Console)
  config.server_timing = true

  # Désactive le cache en développement (les modifications sont visibles immédiatement)
  config.action_controller.perform_caching = false

  # Stocke le cache en mémoire (rapide, remis à zéro au redémarrage du serveur)
  config.cache_store = :memory_store

  # Affiche les requêtes SQL dans la console pour le débogage
  config.log_level = :debug

  # Active les annotations de source dans les vues (affiche le fichier source dans le HTML généré)
  config.action_view.annotate_rendered_view_with_filenames = true

  # ===== CONFIGURATION ACTION MAILER EN DÉVELOPPEMENT =====

  # Utilise la gem Letter Opener : au lieu d'envoyer l'email, ouvre une fenêtre de navigateur
  # Cela permet de visualiser le rendu de l'email sans risquer d'envoyer de vrais mails
  config.action_mailer.delivery_method = :letter_opener

  # Active l'envoi d'emails (nécessaire pour que Letter Opener s'ouvre)
  # Mettre à false pour désactiver complètement tout envoi d'email (utile pour tests unitaires)
  config.action_mailer.perform_deliveries = true

  # URL de base utilisée dans les liens générés dans les emails (ex: lien de bienvenue)
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Affiche les erreurs d'envoi d'email dans la console de développement
  config.action_mailer.raise_delivery_errors = true

  # ===== FIN CONFIGURATION ACTION MAILER =====

  # Affiche les dépréciations dans la console (aide à préparer les migrations futures)
  config.active_support.deprecation = :log

  # Lève une exception sur les requêtes N+1 (force l'utilisation d'includes)
  # config.active_record.action_on_strict_loading_violation = :raise
end
