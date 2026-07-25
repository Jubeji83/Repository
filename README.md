# WSL Toolkit pour Windows (v2.7.11)

Un guide et ensemble d'outils complets pour installer, configurer et optimiser le **Windows Subsystem for Linux (WSL)** nativement sur Windows (Windows 10 & 11).

## 🚀 Nouveautés de la version 2.7.11 (Windows)
- **Support natif amélioré :** Intégration transparente avec les dernières mises à jour de Windows 11 et WSL 2.
- **Gestion des performances :** Optimisation de la consommation de mémoire RAM par la machine virtuelle WSL (`.wslconfig`).
- **Pont réseau mirroir (Mirrored Mode) :** Amélioration de la connectivité réseau et du VPN d'entreprise sous Windows.

---

## 📂 Structure du Projet

```text
wsl-windows/
├── configs/              # Fichiers de configuration globaux (.wslconfig)
├── scripts/              # Scripts d'automatisation PowerShell (.ps1)
├── docs/                 # Documentation d'installation et dépannage
├── .gitignore            # Fichiers ignorés par Git
├── LICENSE               # Licence du projet
└── README.md             # Documentation principale
```

---

## 🛠️ Installation sur Windows

Pour installer et configurer WSL en version 2.7.11 sur votre machine Windows :

1. **Ouvrir PowerShell en tant qu'Administrateur :**
   Faites un clic droit sur le menu Démarrer et choisissez **Terminal (Admin)** ou **PowerShell (Admin)**.

2. **Activer WSL et installer la distribution par défaut :**
   ```powershell
   wsl --install
   ```
   *(Redémarrez votre ordinateur si cela vous est demandé).*

3. **Cloner ce dépôt de configuration :**
   ```powershell
   git clone https://github.com/votre-nom/wsl-windows.git
   cd wsl-windows
   ```

4. **Exécuter le script de configuration (v2.7.11) :**
   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope Process
   .\scripts\setup-wsl.ps1 -Version "2.7.11"
   ```

---

## ⚙️ Configuration Avancée (.wslconfig)

Pour optimiser les ressources de votre machine virtuelle WSL sous Windows, placez le fichier `.wslconfig` (fourni dans le dossier `configs/`) dans votre dossier utilisateur Windows :
`C:\Users\VotreNom\ .wslconfig`

Exemple de configuration optimisée :
```ini
[wsl2]
memory=8GB     # Limite la RAM allouée à WSL
processors=4   # Nombre de cœurs CPU dédiés
swap=2GB       # Espace de swap
networkingMode=mirrored # Mode réseau miroir pour les VPN
```

---

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à ouvrir une *Issue* ou une *Pull Request* pour toute amélioration.

---

## 📄 Licence

Distribué sous la licence MIT. Voir le fichier `LICENSE` pour plus de détails.