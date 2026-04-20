# Gemfile — déclare toutes les dépendances (gems) de l'application Rails

# Spécifie la source principale des gems (dépôt RubyGems officiel)
source 'https://rubygems.org'

# Version de Ruby utilisée par l'application
ruby '3.2.2'

# Framework web Rails — cœur de l'application
gem 'rails', '~> 7.1'

# Adaptateur de base de données PostgreSQL pour la production (Heroku)
gem 'pg', '~> 1.5'

# Serveur web Puma (utilisé par Rails par défaut)
gem 'puma', '~> 6.0'

# Gère les assets CSS/JS de façon optimisée
gem 'sprockets-rails'

# Importe Bootstrap via le système d'assets
gem 'bootstrap', '~> 5.3'

# Transpile le JavaScript moderne pour les navigateurs
gem 'importmap-rails'

# Ajoute Turbo Drive (navigation rapide sans rechargement complet de page)
gem 'turbo-rails'

# Ajoute Stimulus (framework JavaScript léger côté client)
gem 'stimulus-rails'

# Jbuilder — facilite la génération de réponses JSON
gem 'jbuilder'

# Tzinfo-data — données de fuseaux horaires pour Windows et JRuby
gem 'tzinfo-data', platforms: %i[windows jruby]

# Bootsnap — accélère le démarrage de Rails en mettant en cache les fichiers
gem 'bootsnap', require: false

# Dotenv-rails — charge les variables d'environnement depuis le fichier .env
gem 'dotenv-rails'

# Groupe de gems utilisées uniquement en développement et en test
group :development, :test do
  # Débogueur interactif intégré à Rails
  gem 'debug', platforms: %i[mri windows]

  # Meilleures pages d'erreur avec contexte (stack trace, console, etc.)
  gem 'better_errors'

  # Fournit la liaison REPL à better_errors (console interactive dans la page d'erreur)
  gem 'binding_of_caller'
end

# Groupe de gems utilisées uniquement en développement local
group :development do
  # Letter Opener — ouvre les emails dans le navigateur au lieu de les envoyer
  gem 'letter_opener'

  # Web Console — fournit une console Rails dans les pages d'erreur du navigateur
  gem 'web-console'
end

# Groupe de gems utilisées uniquement en test
group :test do
  # Capybara — simule les interactions utilisateur dans les tests d'intégration
  gem 'capybara'

  # Selenium WebDriver — pilote un vrai navigateur pour les tests système
  gem 'selenium-webdriver'
end
