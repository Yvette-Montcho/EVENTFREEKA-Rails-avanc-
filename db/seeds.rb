# db/seeds.rb
# Fichier de seed — peuple la base de données avec des données de démonstration
# Exécuter avec : rails db:seed
# ATTENTION : ce fichier est idempotent (il nettoie les données existantes avant de recréer)

# ===== NETTOYAGE DE LA BASE =====
# Supprime toutes les participations avant les autres (contrainte de clé étrangère)
puts "Nettoyage de la base de données..."
Attendance.destroy_all
# Supprime tous les événements existants
Event.destroy_all
# Supprime tous les utilisateurs existants
User.destroy_all
puts "Base nettoyée ✓"

# ===== CRÉATION DES UTILISATEURS =====
puts "Création des utilisateurs..."

# Utilisateur 1 — Alice, organisatrice d'événements
# On utilise @yopmail.com car ces adresses acceptent tous les emails (idéal pour les tests)
alice = User.create!(
  first_name: "Alice",
  last_name: "Martin",
  email: "alice.martin@yopmail.com",
  encrypted_password: "password_placeholder", # Sera remplacé par Devise demain
  description: "Passionnée d'événements culturels et de musique en live. " \
                "J'organise des soirées depuis 5 ans à Bordeaux."
)
puts "  ✓ Utilisateur créé : #{alice.full_name} (#{alice.email})"

# Utilisateur 2 — Bob, amateur de sport et plein air
bob = User.create!(
  first_name: "Bob",
  last_name: "Dupont",
  email: "bob.dupont@yopmail.com",
  encrypted_password: "password_placeholder",
  description: "Fan de randonnée, running et sports collectifs. " \
                "Je cherche des partenaires de sport pour ne jamais m'entraîner seul !"
)
puts "  ✓ Utilisateur créé : #{bob.full_name} (#{bob.email})"

# Utilisateur 3 — Clara, foodie et amatrice d'ateliers culinaires
clara = User.create!(
  first_name: "Clara",
  last_name: "Leroy",
  email: "clara.leroy@yopmail.com",
  encrypted_password: "password_placeholder",
  description: "Chef cuisinier amateur. J'adore partager des recettes du monde entier."
)
puts "  ✓ Utilisateur créé : #{clara.full_name} (#{clara.email})"

# Utilisateur 4 — David, développeur web et tech enthusiast
david = User.create!(
  first_name: "David",
  last_name: "Bernard",
  email: "david.bernard@yopmail.com",
  encrypted_password: "password_placeholder",
  description: "Développeur full-stack passionné par les nouvelles technologies " \
                "et les événements networking dans la tech."
)
puts "  ✓ Utilisateur créé : #{david.full_name} (#{david.email})"

# Utilisateur 5 — Emma, artiste et amatrice de culture
emma = User.create!(
  first_name: "Emma",
  last_name: "Petit",
  email: "emma.petit@yopmail.com",
  encrypted_password: "password_placeholder",
  description: "Artiste peintre et sculptrice. J'organise des ateliers créatifs " \
                "pour tous les niveaux, débutants comme confirmés."
)
puts "  ✓ Utilisateur créé : #{emma.full_name} (#{emma.email})"

puts "#{User.count} utilisateurs créés ✓"

# ===== CRÉATION DES ÉVÉNEMENTS =====
puts "Création des événements..."

# Événement 1 — Concert jazz (créé par Alice)
# start_date dans le futur → valide selon la règle de validation du model Event
event1 = Event.create!(
  title: "Soirée Jazz au Bar des Arts",
  description: "Une soirée jazz intime dans la meilleure cave de la ville. " \
               "Au programme : standards du jazz américain, bossa nova et fusion. " \
               "Ambiance cosy garantie avec des musiciens professionnels.",
  start_date: 2.weeks.from_now, # 2 semaines à partir d'aujourd'hui
  duration: 120,                # 2 heures (multiple de 5 ✓)
  price: 15,                    # 15 euros (entre 1 et 1000 ✓)
  location: "Bar des Arts, 12 rue de la Paix, Bordeaux",
  user: alice                   # Alice est la créatrice / administratrice de cet événement
)
puts "  ✓ Événement créé : #{event1.title}"

# Événement 2 — Randonnée (créé par Bob)
event2 = Event.create!(
  title: "Grande Randonnée des Landes",
  description: "Partez à la découverte des sentiers secrets des Landes de Gascogne " \
               "avec un groupe de randonneurs expérimentés. Difficulté : intermédiaire. " \
               "Prévoir des chaussures de marche, un imperméable et de l'eau.",
  start_date: 10.days.from_now, # Dans 10 jours
  duration: 240,                # 4 heures (multiple de 5 ✓)
  price: 20,                    # 20 euros
  location: "Départ : Parking de la forêt, Route des Pins, Biscarrosse",
  user: bob
)
puts "  ✓ Événement créé : #{event2.title}"

# Événement 3 — Atelier cuisine (créé par Clara)
event3 = Event.create!(
  title: "Atelier Cuisine du Monde : Cuisine Thaïlandaise",
  description: "Apprenez à cuisiner 3 plats emblématiques de la cuisine thaïlandaise " \
               "(Pad Thaï, Green Curry, Mango Sticky Rice) avec Clara, chef cuisinière " \
               "de retour de Bangkok. Tous les ingrédients sont fournis.",
  start_date: 3.weeks.from_now, # Dans 3 semaines
  duration: 180,                # 3 heures (multiple de 5 ✓)
  price: 45,                    # 45 euros (inclut les ingrédients)
  location: "Studio Culinaire Clara, 8 allée des Saveurs, Bordeaux",
  user: clara
)
puts "  ✓ Événement créé : #{event3.title}"

# Événement 4 — Meetup tech (créé par David)
event4 = Event.create!(
  title: "Bordeaux Ruby Meetup #12",
  description: "Rejoignez-nous pour la 12ème édition du meetup Ruby/Rails de Bordeaux ! " \
               "Au programme : deux talks de 20 minutes sur Rails 7 et Hotwire, " \
               "suivi d'un networking avec pizzas et boissons. Venez nombreux !",
  start_date: 1.month.from_now, # Dans 1 mois
  duration: 120,                # 2 heures (multiple de 5 ✓)
  price: 10,                    # 10 euros (couvre les pizzas et boissons)
  location: "La Cantine du Libre, 201 cours de la Marne, Bordeaux",
  user: david
)
puts "  ✓ Événement créé : #{event4.title}"

# Événement 5 — Atelier peinture (créé par Emma)
event5 = Event.create!(
  title: "Atelier Peinture Aquarelle pour Débutants",
  description: "Découvrez la magie de l'aquarelle lors de cet atelier bienveillant " \
               "pour tous les niveaux. Emma vous guidera pas à pas pour créer " \
               "votre premier tableau. Tout le matériel est fourni.",
  start_date: 5.days.from_now, # Dans 5 jours
  duration: 150,               # 2h30 (multiple de 5 ✓)
  price: 35,                   # 35 euros (matériel inclus)
  location: "Atelier Emma Petit, 45 rue des Artistes, Bordeaux",
  user: emma
)
puts "  ✓ Événement créé : #{event5.title}"

puts "#{Event.count} événements créés ✓"

# ===== CRÉATION DES PARTICIPATIONS =====
puts "Création des participations..."

# Bob et Clara participent à la soirée Jazz d'Alice
# NOTE : les callbacks after_create du model Attendance enverront des emails à Alice
Attendance.create!(user: bob,   event: event1)
puts "  ✓ #{bob.full_name} participe à : #{event1.title}"
Attendance.create!(user: clara, event: event1)
puts "  ✓ #{clara.full_name} participe à : #{event1.title}"

# Alice participe à la randonnée de Bob
Attendance.create!(user: alice, event: event2)
puts "  ✓ #{alice.full_name} participe à : #{event2.title}"

# Alice et David participent à l'atelier cuisine de Clara
Attendance.create!(user: alice, event: event3)
puts "  ✓ #{alice.full_name} participe à : #{event3.title}"
Attendance.create!(user: david, event: event3)
puts "  ✓ #{david.full_name} participe à : #{event3.title}"

# Alice, Bob et Clara participent au meetup Ruby de David
Attendance.create!(user: alice, event: event4)
puts "  ✓ #{alice.full_name} participe à : #{event4.title}"
Attendance.create!(user: bob,   event: event4)
puts "  ✓ #{bob.full_name} participe à : #{event4.title}"
Attendance.create!(user: clara, event: event4)
puts "  ✓ #{clara.full_name} participe à : #{event4.title}"

# Bob et David participent à l'atelier peinture d'Emma
Attendance.create!(user: bob,   event: event5)
puts "  ✓ #{bob.full_name} participe à : #{event5.title}"
Attendance.create!(user: david, event: event5)
puts "  ✓ #{david.full_name} participe à : #{event5.title}"

puts "#{Attendance.count} participations créées ✓"

# ===== RÉSUMÉ FINAL =====
puts ""
puts "============================================"
puts "Seed terminé avec succès !"
puts "  Utilisateurs : #{User.count}"
puts "  Événements   : #{Event.count}"
puts "  Participations: #{Attendance.count}"
puts "============================================"
