# db/migrate/20240420000001_create_users.rb
# Migration pour créer la table "users" en base de données
# Les champs email et encrypted_password sont préparés pour la gem Devise (intégrée demain)

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    # Crée la table "users" avec sa clé primaire id auto-incrémentée
    create_table :users do |t|

      # Champ email — identifiant unique de l'utilisateur
      # null: false → obligatoire, default: "" → préparé pour Devise
      t.string :email, null: false, default: ""

      # Champ encrypted_password — mot de passe haché (géré par Devise demain)
      # null: false → obligatoire, default: "" → préparé pour Devise
      t.string :encrypted_password, null: false, default: ""

      # Prénom de l'utilisateur — affiché sur le profil et dans les emails
      t.string :first_name

      # Nom de famille de l'utilisateur — affiché sur le profil
      t.string :last_name

      # Description du profil — texte libre pour se présenter
      t.text :description

      # Ajoute les colonnes created_at et updated_at (gérées automatiquement par Rails)
      t.timestamps
    end

    # Crée un index unique sur email pour garantir l'unicité en base et accélérer les recherches
    add_index :users, :email, unique: true
  end
end
