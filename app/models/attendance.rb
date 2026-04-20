# app/models/attendance.rb
# Model Attendance — représente la participation d'un utilisateur à un événement
# C'est la table de jointure entre User et Event (relation many-to-many)
# Elle stocke aussi l'identifiant Stripe pour la traçabilité des paiements

class Attendance < ApplicationRecord

  # ===== ASSOCIATIONS =====

  # Une participation appartient à un utilisateur (le participant)
  # obligatoire : pas de participation sans utilisateur identifié
  belongs_to :user

  # Une participation appartient à un événement
  # obligatoire : pas de participation sans événement associé
  belongs_to :event

  # ===== VALIDATIONS =====

  # Un utilisateur ne peut s'inscrire qu'une seule fois à un même événement
  # scope: :event → l'unicité est vérifiée au sein de l'événement (pas globalement)
  validates :user_id, uniqueness: {
    scope: :event_id,
    message: "est déjà inscrit à cet événement"
  }

  # ===== CALLBACKS =====

  # Déclenché automatiquement APRÈS qu'une participation est sauvegardée en base pour la première fois
  # Envoie un email de notification au créateur de l'événement
  after_create :notify_event_creator

  private

  # ===== MÉTHODES PRIVÉES =====

  # Notifie le créateur de l'événement qu'un nouveau participant vient de rejoindre son événement
  # self → passe l'instance de la participation au mailer pour accéder à user et event
  def notify_event_creator
    UserMailer.new_attendance_email(self).deliver_now
  end
end
