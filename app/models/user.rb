# app/models/user.rb
# Model User — représente un utilisateur de la plateforme EventFreeka
# Gère les associations avec les événements et les participations,
# ainsi que l'envoi automatique d'un email de bienvenue à la création.

class User < ApplicationRecord

  # ===== ASSOCIATIONS =====

  # Un utilisateur peut administrer (créer) plusieurs événements
  # dependent: :destroy → si l'utilisateur est supprimé, ses événements le sont aussi
  has_many :events, dependent: :destroy

  # Un utilisateur peut avoir plusieurs participations (inscriptions à des événements)
  # dependent: :destroy → si l'utilisateur est supprimé, ses participations sont supprimées aussi
  has_many :attendances, dependent: :destroy

  # Un utilisateur peut participer à plusieurs événements AU TRAVERS de ses participations
  # (association many-to-many via la table attendances)
  has_many :attended_events, through: :attendances, source: :event

  # ===== VALIDATIONS =====

  # L'email est obligatoire — c'est l'identifiant principal de l'utilisateur
  validates :email, presence: true

  # L'email doit être unique — deux utilisateurs ne peuvent pas avoir le même email
  validates :email, uniqueness: { case_sensitive: false }

  # Format de l'email validé avec une expression régulière simple
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "n'est pas valide" }

  # Le prénom est obligatoire pour personnaliser les emails et le profil
  validates :first_name, presence: true

  # Le nom de famille est obligatoire
  validates :last_name, presence: true

  # La description est optionnelle mais limitée à 500 caractères si renseignée
  validates :description, length: { maximum: 500 }, allow_blank: true

  # ===== CALLBACKS =====

  # Déclenché automatiquement APRÈS qu'un utilisateur est sauvegardé en base pour la première fois
  # Envoie un email de bienvenue via le UserMailer
  after_create :send_welcome_email

  # ===== MÉTHODES PUBLIQUES =====

  # Retourne le nom complet de l'utilisateur (prénom + nom)
  # Utilisé dans les vues et les emails pour personnaliser l'affichage
  def full_name
    "#{first_name} #{last_name}"
  end

  private

  # ===== MÉTHODES PRIVÉES =====

  # Envoie l'email de bienvenue en utilisant le UserMailer
  # deliver_now → envoi immédiat et synchrone (pas de file d'attente)
  # self → passe l'instance de l'utilisateur venant d'être créé au mailer
  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
