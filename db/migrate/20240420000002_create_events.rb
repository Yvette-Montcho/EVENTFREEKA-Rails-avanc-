# db/migrate/20240420000002_create_events.rb
# Migration pour créer la table "events" en base de données
# Un événement appartient à un utilisateur (son créateur/administrateur)

class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    # Crée la table "events" avec sa clé primaire id auto-incrémentée
    create_table :events do |t|

      # Titre de l'événement — affiché partout, doit être descriptif
      t.string :title, null: false

      # Description détaillée de l'événement — texte long
      t.text :description, null: false

      # Date et heure de début de l'événement (datetime = date + heure)
      t.datetime :start_date, null: false

      # Durée en minutes (ex: 60 = 1h, 90 = 1h30, multiple de 5)
      t.integer :duration, null: false

      # Prix en euros entiers (pas de centimes, entre 1 et 1000)
      t.integer :price, null: false

      # Lieu de l'événement — adresse ou nom du lieu
      t.string :location, null: false

      # Clé étrangère vers l'utilisateur créateur de l'événement
      # foreign_key: true → contrainte d'intégrité référentielle en base
      t.references :user, null: false, foreign_key: true

      # Ajoute les colonnes created_at et updated_at (gérées automatiquement par Rails)
      t.timestamps
    end

    # Index sur start_date pour accélérer les tris et filtrages par date
    add_index :events, :start_date

    # Index sur user_id (créé automatiquement par t.references, mais explicité ici)
    # Accélère les requêtes "tous les événements de l'utilisateur X"
  end
end
