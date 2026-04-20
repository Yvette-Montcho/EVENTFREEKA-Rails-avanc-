# EventFreeka 🎉

**EventFreeka** est une application web Ruby on Rails inspirée d'Eventbrite, permettant aux utilisateurs de créer et rejoindre des événements locaux. Le projet couvre la mise en place d'une base de données relationnelle complète ainsi qu'un système d'emails automatiques avec Action Mailer.

---

## Nom du repository GitHub recommandé

```
eventfreeka
```

> Ce nom est court, mémorable, unique et reflète parfaitement le nom de l'application.

---

## Fonctionnalités principales

- **Gestion des utilisateurs** : inscription, profil, édition et suppression de compte
- **Gestion des événements** : création, consultation, édition et suppression
- **Participations** : inscription à un événement avec validation anti-doublon
- **Emails automatiques** via Action Mailer :
  - Email de bienvenue à la création d'un utilisateur
  - Email de notification au créateur quand un participant rejoint son événement
- **Environnements séparés** : Letter Opener en développement, SendGrid en production

---

## Architecture du projet

```
eventfreeka/
├── app/
│   ├── mailers/
│   │   ├── application_mailer.rb        # Mailer de base (expéditeur, layout)
│   │   └── user_mailer.rb               # Emails utilisateurs (bienvenue + notification)
│   ├── models/
│   │   ├── user.rb                      # Model utilisateur + callback after_create
│   │   ├── event.rb                     # Model événement + validations métier
│   │   └── attendance.rb                # Model participation + callback after_create
│   └── views/
│       └── user_mailer/
│           ├── welcome_email.html.erb   # Template HTML email de bienvenue
│           ├── welcome_email.text.erb   # Template texte email de bienvenue
│           ├── new_attendance_email.html.erb  # Template HTML notification participation
│           └── new_attendance_email.text.erb  # Template texte notification participation
├── config/
│   ├── environment.rb                   # Config SMTP SendGrid (production)
│   ├── routes.rb                        # Toutes les routes de l'application
│   └── environments/
│       ├── development.rb               # Config Letter Opener (développement)
│       └── production.rb                # Config envoi réel d'emails (production)
├── db/
│   ├── migrate/
│   │   ├── 20240420000001_create_users.rb
│   │   ├── 20240420000002_create_events.rb
│   │   └── 20240420000003_create_attendances.rb
│   └── seeds.rb                         # Données de démonstration
├── .env.example                         # Modèle des variables d'environnement
├── .gitignore                           # Fichiers exclus du suivi Git
└── Gemfile                              # Dépendances Ruby (gems)
```

---

## Prérequis

Avant de lancer le projet, assurez-vous d'avoir installé :

| Outil | Version recommandée | Vérification |
|-------|---------------------|--------------|
| Ruby | 3.2.2 | `ruby -v` |
| Rails | 7.1.x | `rails -v` |
| PostgreSQL | 14+ | `psql --version` |
| Bundler | 2.x | `bundler -v` |
| Node.js | 18+ | `node -v` |
| Git | 2.x | `git --version` |

---

## Extensions VS Code à installer

Installez ces extensions **avant** d'ouvrir le projet dans VS Code pour une expérience optimale :

| Extension | Identifiant | Utilité |
|-----------|-------------|---------|
| **Ruby LSP** | `Shopify.ruby-lsp` | Autocomplétion, navigation et diagnostics Ruby |
| **Rails** | `bung.rails` | Support ERB, routes Rails, snippets |
| **ERB Formatter/Beautify** | `aliariff.vscode-erb-beautify` | Formatage automatique des fichiers `.erb` |
| **GitLens** | `eamodio.gitlens` | Historique Git enrichi dans l'éditeur |
| **DotENV** | `mikestead.dotenv` | Coloration syntaxique des fichiers `.env` |
| **PostgreSQL** | `cweijan.vscode-postgresql-client2` | Interface graphique pour la BDD |
| **Better Comments** | `aaron-bond.better-comments` | Colorise les commentaires par catégorie |
| **Auto Rename Tag** | `formulahendry.auto-rename-tag` | Renommage simultané des balises HTML/ERB |
| **Indent Rainbow** | `oderwat.indent-rainbow` | Colorise les niveaux d'indentation |
| **Thunder Client** | `rangav.vscode-thunder-client` | Tester les endpoints de l'API REST |

**Installation rapide via le terminal VS Code :**

```bash
code --install-extension Shopify.ruby-lsp
code --install-extension bung.rails
code --install-extension aliariff.vscode-erb-beautify
code --install-extension eamodio.gitlens
code --install-extension mikestead.dotenv
code --install-extension cweijan.vscode-postgresql-client2
code --install-extension aaron-bond.better-comments
code --install-extension formulahendry.auto-rename-tag
code --install-extension oderwat.indent-rainbow
code --install-extension rangav.vscode-thunder-client
```

---

## Installation et exécution avec VS Code

### Étape 1 — Cloner le dépôt

```bash
git clone https://github.com/VOTRE_PSEUDO/eventfreeka.git
cd eventfreeka
```

### Étape 2 — Ouvrir dans VS Code

```bash
code .
```

> Dans VS Code, ouvrez le terminal intégré avec `Ctrl+`` (backtick) ou via le menu **Terminal > Nouveau terminal**.

### Étape 3 — Installer les gems (dépendances Ruby)

```bash
bundle install
```

### Étape 4 — Configurer les variables d'environnement

Copiez le fichier exemple `.env.example` en `.env` :

```bash
cp .env.example .env
```

Ouvrez `.env` dans VS Code et renseignez vos valeurs :

```env
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=votre_mot_de_passe
SENDGRID_LOGIN=apikey
SENDGRID_PWD=SG.votre_cle_sendgrid
```

### Étape 5 — Créer et migrer la base de données

```bash
rails db:create
rails db:migrate
```

### Étape 6 — Peupler la base avec les données de démonstration

> ⚠️ Note : le seed déclenche les callbacks `after_create`, ce qui ouvrira des emails dans votre navigateur via Letter Opener (comportement normal en développement).

```bash
rails db:seed
```

### Étape 7 — Lancer le serveur Rails

```bash
rails server
```

Ouvrez votre navigateur sur [http://localhost:3000](http://localhost:3000).

**Raccourci VS Code** : Utilisez le panneau **Run and Debug** (`Ctrl+Shift+D`) pour démarrer le serveur sans quitter VS Code, ou créez un fichier `.vscode/launch.json` (voir ci-dessous).

### Optionnel — Configuration du débogueur VS Code

Créez le fichier `.vscode/launch.json` à la racine du projet :

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Rails Server",
      "type": "ruby_lsp",
      "request": "launch",
      "program": "${workspaceFolder}/bin/rails",
      "args": ["server"]
    }
  ]
}
```

Puis lancez avec `F5` ou le bouton ▶️ dans le panneau Run and Debug.

---

## Tester les emails en développement

La gem **Letter Opener** est configurée : tout email déclenché par l'application s'ouvrira automatiquement dans votre navigateur par défaut.

**Tester le mailer depuis la console Rails :**

```bash
rails console
```

```ruby
# Créer un utilisateur → email de bienvenue s'ouvre dans le navigateur
User.create!(
  first_name: "Test",
  last_name: "User",
  email: "test@yopmail.com",
  encrypted_password: "placeholder"
)

# Créer une participation → email de notification au créateur
event = Event.first
user  = User.last
Attendance.create!(user: user, event: event)
```

---

## Déploiement sur Heroku

```bash
# 1. Créer l'application Heroku
heroku create eventfreeka

# 2. Configurer les variables d'environnement SendGrid
heroku config:set SENDGRID_LOGIN='apikey'
heroku config:set SENDGRID_PWD='SG.votre_cle_api'

# 3. Déployer
git push heroku main

# 4. Migrer la base de données Heroku
heroku run rails db:migrate

# 5. Peupler la base Heroku
heroku run rails db:seed

# 6. Vérifier les variables d'environnement depuis la console Heroku
heroku run rails console
# Puis : ENV['SENDGRID_PWD']  # Doit retourner votre clé (pas nil)
```

---

## Modèle de données

```
┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐
│      User       │         │   Attendance    │         │      Event      │
├─────────────────┤         ├─────────────────┤         ├─────────────────┤
│ id              │ 1     * │ id              │ *     1 │ id              │
│ email           │────────>│ user_id (FK)    │<────────│ title           │
│ encrypted_pwd   │         │ event_id (FK)   │         │ description     │
│ first_name      │         │ stripe_cust._id │         │ start_date      │
│ last_name       │         │ created_at      │         │ duration        │
│ description     │         │ updated_at      │         │ price           │
│ created_at      │         └─────────────────┘         │ location        │
│ updated_at      │                                      │ user_id (FK)    │
└─────────────────┘                                      │ created_at      │
                                                         │ updated_at      │
                                                         └─────────────────┘
```

---

## Gems principales utilisées

| Gem | Rôle |
|-----|------|
| `rails 7.1` | Framework web principal |
| `pg` | Base de données PostgreSQL |
| `letter_opener` | Visualiser les emails en développement |
| `dotenv-rails` | Gestion des variables d'environnement |
| `better_errors` | Pages d'erreur améliorées en développement |
| `binding_of_caller` | Console interactive dans les pages d'erreur |
| `bootstrap 5` | Framework CSS pour l'interface |

---

## Auteur

Projet réalisé dans le cadre de la formation **The Hacking Project (THP)** — Semaine 7, Jour 1.

---

## Licence

Ce projet est open source et disponible sous la licence [MIT](https://opensource.org/licenses/MIT).
