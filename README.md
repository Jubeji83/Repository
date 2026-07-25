## 📂 Structure du Projet

```text
wsl/
├── .github/              # Modèles d'issues et workflows CI/CD
├── configs/              # Fichiers de configuration (.wslconfig, wsl.conf, bashrc)
├── docs/                 # Documentation détaillée
├── scripts/              # Scripts d'automatisation (installation, setup)
├── src/                  # Code source principal
├── .gitignore            # Fichiers ignorés par Git
├── LICENSE               # Licence du projet
└── README.md             # Documentation principale
```

---

## 🛠️ Installation

1. Cloner le dépôt :
   ```bash
   git clone https://github.com/votre-nom/wsl.git
   cd wsl
   ```

2. Exécuter le script d'installation de la version 2.7.11 :
   ```bash
   chmod +x scripts/install.sh
   ./scripts/install.sh --version 2.7.11
   ```

---

## ⚙️ Configuration

Consultez le dossier `configs/` pour personnaliser vos fichiers de configuration selon vos besoins :
- `.wslconfig` (niveau global Windows)
- `wsl.conf` (niveau distribution Linux)

---

## 🤝 Contribution

Les contributions sont les bienvenues ! Veuillez consulter les directives du projet avant de soumettre une Pull Request.

---

## 📄 Licence

Distribué sous la licence MIT. Voir le fichier `LICENSE` pour plus d'informations.
