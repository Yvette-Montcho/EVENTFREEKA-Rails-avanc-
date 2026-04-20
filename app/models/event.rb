# app/models/event.rb
# Model Event — représente un événement créé par un utilisateur sur EventFreeka
# Gère les associations avec les participants et les validations métier.

class Event < ApplicationRecord

  # ===== ASSOCIATIONS =====

  # Un événement appartient à un utilisateur (son créateur, appelé "administrateur" de l'événement)
  # Il est obligatoire (null: false en base) — un événement sans créateur n'a pas de sens
  belongs_to :user

  # Un événement peut avoir plusieurs participations (inscriptions)
  # dependent: :destroy → si l'événement est supprimé, toutes ses participations le sont aussi
  has_many :attendances, dependent: :destroy

  # Un événement peut avoir plusieurs participants (utilisateurs) AU TRAVERS des participations
  # (association many-to-many via la table attendances)
  has_many :participants, through: :attendances, source: :user

  # ===== VALIDATIONS =====

  # Le titre est obligatoire — c'est le premier élément visible de l'événement
  validates :title, presence: true

  # Longueur du titre : minimum 5 caractères (trop court = pas descriptif) et max 140
  validates :title, length: { minimum: 5, maximum: 140 }

  # La description est obligatoire pour donner du contexte aux participants potentiels
  validates :description, presence: true

  # Longueur de la description : entre 20 et 1000 caractères
  validates :description, length: { minimum: 20, maximum: 1000 }

  # La date de début est obligatoire — sans elle, impossible de planifier
  validates :start_date, presence: true

  # Valide que la date de début n'est pas dans le passé (création ET modification)
  validate :start_date_cannot_be_in_the_past

  # La durée est obligatoire — exprimée en minutes
  validates :duration, presence: true

  # La durée doit être un entier strictement positif
  validates :duration, numericality: { only_integer: true, greater_than: 0 }

  # La durée doit être un multiple de 5 minutes (ex: 30, 60, 90...)
  validate :duration_must_be_multiple_of_five

  # Le prix est obligatoire — en euros entiers (pas d'événement gratuit)
  validates :price, presence: true

  # Le prix doit être un entier entre 1 et 1000 euros
  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 1000
  }

  # Le lieu est obligatoire — pour que les participants sachent où se rendre
  validates :location, presence: true

  # ===== MÉTHODES PUBLIQUES =====

  # Retourne le nombre de participants inscrits à l'événement
  # Utilisé dans les vues pour afficher "X participants"
  def participants_count
    attendances.count
  end

  # Retourne la date de fin calculée à partir de start_date + duration (en minutes)
  # Pratique pour afficher l'heure de fin dans les vues
  def end_date
    start_date + duration.minutes
  end

  private

  # ===== VALIDATIONS PERSONNALISÉES (MÉTHODES PRIVÉES) =====

  # Vérifie que la date de début n'est pas dans le passé
  # Rails appelle automatiquement cette méthode grâce à la directive "validate"
  def start_date_cannot_be_in_the_past
    # Vérifie que start_date est bien renseignée avant de la comparer (évite une NoMethodError)
    if start_date.present? && start_date < Time.current
      # Ajoute une erreur sur le champ start_date avec un message explicite
      errors.add(:start_date, "ne peut pas être dans le passé")
    end
  end

  # Vérifie que la durée est un multiple de 5
  def duration_must_be_multiple_of_five
    # Vérifie que duration est bien renseignée avant de faire la division (évite une NoMethodError)
    if duration.present? && duration % 5 != 0
      # Ajoute une erreur sur le champ duration avec un message explicite
      errors.add(:duration, "doit être un multiple de 5 minutes")
    end
  end
end
