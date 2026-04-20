# app/mailers/application_mailer.rb
# Mailer de base dont héritent tous les autres mailers de l'application
# Définit les paramètres communs à tous les emails envoyés par EventFreeka

class ApplicationMailer < ActionMailer::Base

  # Adresse d'expéditeur par défaut pour tous les emails de l'application
  # Apparaîtra dans le champ "De :" du client email du destinataire
  default from: 'no-reply@eventfreeka.com'

  # Layout utilisé pour envelopper les vues d'emails HTML
  # Correspond au fichier app/views/layouts/mailer.html.erb
  layout 'mailer'
end
