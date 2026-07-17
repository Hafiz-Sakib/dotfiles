# 🚀 Linux Dotfiles

A fully automated Linux dotfiles repository for quickly setting up a fresh system.

Supports:

- Ubuntu
- Zorin OS
- Debian
- Linux Mint
- Other Debian-based distributions

---

# ✨ Features

- 📦 Install APT packages
- 📦 Install Flatpak packages
- 📦 Install Snap packages
- 💻 Install VS Code extensions
- 🎨 Restore GTK theme
- 🖼 Restore Icon theme
- 🔤 Restore Fonts
- ⚡ Restore Fastfetch configuration
- 🐚 Restore Bash configuration
- ⚙ Restore Git configuration
- 🧩 Restore GNOME Extensions
- 🧠 Restore GNOME Settings (dconf)
- 🔗 GNU Stow based configuration
- 🔄 One-command backup
- 🚀 One-command installation

---

# 📁 Project Structure

```text
dotfiles/
├── bash/
├── dconf/
├── fastfetch/
├── fonts/
├── git/
├── gtk/
├── icons/
├── packages/
├── profile/
├── scripts/
├── themes/
├── vscode/
└── README.md
```

---

# ⚡ Installation

Clone the repository

```bash
git clone https://github.com/Hafiz-Sakib/dotfiles.git
```

Go inside

```bash
cd dotfiles
```

Run bootstrap

```bash
./scripts/bootstrap.sh
```

---

# 🔄 Backup

Update every package list and push changes

```bash
./scripts/backup.sh
```

---

# 🛠 Restore

Restore your system

```bash
./scripts/install.sh
```

---

# 📦 What gets backed up?

✅ Installed APT packages

✅ Installed Flatpak packages

✅ Installed Snap packages

✅ VS Code extensions

✅ Fonts

✅ GTK theme

✅ Icons

✅ Fastfetch

✅ Bash configuration

✅ Git configuration

✅ GNOME Extensions

✅ GNOME dconf settings

---

# 📌 Requirements

- git
- curl
- stow
- pipx
- flatpak
- snap

---

# 🛣 Roadmap

## ✅ Phase 1

- Basic Stow
- Git

## ✅ Phase 2

- Package backup

## ✅ Phase 3

- Installer

## ✅ Phase 4

- GNOME Extensions
- GNOME Settings

## 🚧 Phase 5

- Professional README
- Interactive Installer


## 📚 Documentation

- 📜 [Script Usage Guide](scripts.md)
- 🔧 [Git & GitHub Setup Guide](setup-git.md)
## 🔮 Future

- Distro detection
- Rollback support
- Dry-run mode
- Error recovery
- GitHub Actions

---

# 📜 License

MIT License

---

# 👨‍💻 Author

**Sakib**

GitHub:

https://github.com/Hafiz-Sakib
