# db/migrate/20240420000003_create_attendances.rb
# Migration pour créer la table "attendances" en base de données
# Une participation est la table de jointure entre un utilisateur et un événement
# Elle stocke également l'identifiant Stripe du paiement pour la traçabilité

class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    # Crée la table "attendances" avec sa clé primaire id auto-incrémentée
    create_table :attendances do |t|

      # Clé étrangère vers l'utilisateur participant à l'événement
      # foreign_key: true → contrainte d'intégrité référentielle (suppression impossible si lié)
      t.references :user, null: false, foreign_key: true

      # Clé étrangère vers l'événement auquel l'utilisateur participe
      # foreign_key: true → contrainte d'intégrité référentielle
      t.references :event, null: false, foreign_key: true

      # Identifiant client Stripe — stocké après le paiement pour référence future
      # Permet de récupérer les informations de paiement côté Stripe si besoin
      # Peut être nil si l'intégration Stripe n'est pas encore faite
      t.string :stripe_customer_id

      # Ajoute les colonnes created_at et updated_at (gérées automatiquement par Rails)
      t.timestamps
    end

    # Index composite pour empêcher qu'un utilisateur s'inscrive deux fois au même événement
    # unique: true → contrainte d'unicité au niveau base de données (double sécurité avec validation model)
    add_index :attendances, [:user_id, :event_id], unique: true
  end
end
