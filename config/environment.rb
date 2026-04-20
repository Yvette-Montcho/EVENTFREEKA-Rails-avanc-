# config/environment.rb — point d'entrée de la configuration Rails
# Ce fichier charge l'application et définit les paramètres globaux (SMTP, etc.)

# Charge les fichiers d'initialisation de Rails et de l'application
require_relative 'application'

# Lance l'initialisation complète de Rails (charge tous les initializers)
Rails.application.initialize!

# ===== CONFIGURATION SMTP POUR L'ENVOI D'EMAILS EN PRODUCTION (SendGrid) =====
# Ces paramètres sont utilisés par Action Mailer pour envoyer les emails via SendGrid.
# Les identifiants sont stockés dans .env (jamais en dur dans le code).
ActionMailer::Base.smtp_settings = {
  # Login SendGrid — toujours la chaîne littérale 'apikey'
  user_name: ENV['SENDGRID_LOGIN'],

  # Clé API SendGrid — récupérée depuis la variable d'environnement SENDGRID_PWD
  password: ENV['SENDGRID_PWD'],

  # Domaine de l'application (utilisé comme identifiant SMTP)
  domain: 'eventfreeka.com',

  # Adresse du serveur SMTP de SendGrid
  address: 'smtp.sendgrid.net',

  # Port SMTP recommandé par SendGrid pour les connexions chiffrées TLS
  port: 587,

  # Méthode d'authentification SMTP (plain = identifiant + mot de passe en clair sur TLS)
  authentication: :plain,

  # Active le chiffrement STARTTLS pour sécuriser la connexion SMTP
  enable_starttls_auto: true
}
