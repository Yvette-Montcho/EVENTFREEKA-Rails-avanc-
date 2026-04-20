# app/mailers/user_mailer.rb
# UserMailer — gère tous les emails envoyés aux utilisateurs d'EventFreeka
# Hérite de ApplicationMailer qui définit l'expéditeur par défaut et le layout

class UserMailer < ApplicationMailer

  # Adresse d'expéditeur spécifique pour les emails utilisateurs
  # Écrase la valeur par défaut définie dans ApplicationMailer
  default from: 'no-reply@eventfreeka.com'

  # =========================================================================
  # Méthode : welcome_email
  # But : envoyer un email de bienvenue à un utilisateur qui vient de s'inscrire
  # Appelée par le callback after_create du model User
  # Paramètre : user → instance du model User qui vient d'être créé en base
  # =========================================================================
  def welcome_email(user)
    # Stocke l'utilisateur dans une variable d'instance pour la rendre accessible dans la vue
    @user = user

    # URL de connexion passée à la vue pour créer un lien cliquable dans l'email
    @url = 'http://eventfreeka.com/login'

    # Envoie l'email avec les métadonnées de base
    # to: → adresse du destinataire (l'utilisateur qui vient de s'inscrire)
    # subject: → objet de l'email affiché dans la boîte de réception
    # Rails cherche automatiquement les vues app/views/user_mailer/welcome_email.html.erb
    # et app/views/user_mailer/welcome_email.text.erb pour générer les deux versions
    mail(
      to: @user.email,
      subject: "Bienvenue sur EventFreeka, #{@user.first_name} ! 🎉"
    )
  end

  # =========================================================================
  # Méthode : new_attendance_email
  # But : notifier le créateur d'un événement qu'un nouveau participant l'a rejoint
  # Appelée par le callback after_create du model Attendance
  # Paramètre : attendance → instance de la participation qui vient d'être créée
  # =========================================================================
  def new_attendance_email(attendance)
    # Récupère la participation pour accéder à l'utilisateur ET à l'événement
    @attendance = attendance

    # Récupère le participant (l'utilisateur qui vient de s'inscrire à l'événement)
    @participant = attendance.user

    # Récupère l'événement concerné par la participation
    @event = attendance.event

    # Récupère le créateur de l'événement — c'est LUI qui reçoit cette notification
    @creator = @event.user

    # URL de la page de l'événement (liste des participants) pour que le créateur puisse consulter
    @event_url = "http://eventfreeka.com/events/#{@event.id}"

    # Envoie l'email de notification au créateur (pas au participant !)
    mail(
      to: @creator.email,
      subject: "Nouveau participant à votre événement : #{@event.title}"
    )
  end
end
