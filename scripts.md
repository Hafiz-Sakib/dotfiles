# 📜 স্ক্রিপ্ট ব্যবহারের নির্দেশিকা

এই প্রজেক্টে একাধিক স্ক্রিপ্ট রয়েছে। তবে সবগুলো প্রতিদিন ব্যবহার করার জন্য নয়। নিচে প্রতিটি স্ক্রিপ্টের কাজ এবং কখন ব্যবহার করতে হবে তা দেওয়া হলো।

---

## ⭐ `bootstrap.sh` (প্রধান Entry Point)

### কখন ব্যবহার করবেন?

নতুন Linux ইনস্টল করার পর, অর্থাৎ একদম Fresh System-এ।

উদাহরণ:

- নতুন SSD
- নতুন Laptop
- নতুন Virtual Machine (VM)
- নতুন Zorin OS
- নতুন Ubuntu
- নতুন Debian

### চালানোর কমান্ড

```bash
git clone https://github.com/Hafiz-Sakib/dotfiles.git

cd dotfiles

./scripts/bootstrap.sh
```

এটাই সাধারণ ব্যবহারকারীর চালানোর জন্য প্রধান স্ক্রিপ্ট।

এটি স্বয়ংক্রিয়ভাবে—

- প্রয়োজনীয় Package ইনস্টল করবে
- সব Script-কে Executable করবে
- `install.sh` চালু করবে

---

## 📦 `install.sh`

### কখন ব্যবহার করবেন?

সাধারণত **ম্যানুয়ালি চালানোর প্রয়োজন নেই**।

এটি `bootstrap.sh` থেকেই স্বয়ংক্রিয়ভাবে চালু হয়।

### এটি যা করে

- APT Package ইনস্টল
- Flatpak Package ইনস্টল
- Snap Package ইনস্টল
- VS Code Extension ইনস্টল
- GNU Stow প্রয়োগ
- GNOME Extension Restore
- GNOME (dconf) Settings Restore
- Font Cache Refresh

---

## 💾 `backup.sh`

### কখন ব্যবহার করবেন?

যখন বর্তমান Linux Setup সংরক্ষণ (Backup) করতে চান।

উদাহরণ:

- নতুন GNOME Extension ইনস্টল করলে
- নতুন Theme বা Icon ব্যবহার করলে
- VS Code Extension পরিবর্তন করলে
- নতুন Package ইনস্টল করলে
- GNOME Settings পরিবর্তন করলে

### চালানোর কমান্ড

```bash
./scripts/backup.sh
```

এই স্ক্রিপ্ট আপনার বর্তমান Configuration Backup করে GitHub Repository আপডেট করতে সাহায্য করবে।

---

## ♻️ `restore.sh`

### কখন ব্যবহার করবেন?

যখন সম্পূর্ণ Configuration আবার Restore করতে চান।

উদাহরণ:

- ভুলবশত কোনো Config Delete হয়ে গেলে
- Symlink পুনরায় তৈরি করতে হলে
- Bootstrap ছাড়া শুধুমাত্র Configuration Restore করতে চাইলে

### চালানোর কমান্ড

```bash
./scripts/restore.sh
```

---

## 🖥️ `restore-dconf.sh`

### কখন ব্যবহার করবেন?

এটি খুব কম ব্যবহার করতে হবে।

শুধুমাত্র যদি—

- GNOME Settings নষ্ট হয়ে যায়
- Theme, Shortcut বা Desktop Configuration Reset হয়ে যায়

### চালানোর কমান্ড

```bash
./scripts/restore-dconf.sh
```

---

## 🧩 `restore-extensions.sh`

### কখন ব্যবহার করবেন?

এটিও খুব কম ব্যবহার করতে হবে।

শুধুমাত্র যদি—

- GNOME Extension Remove হয়ে যায়
- Extension পুনরায় Install করতে চান

### চালানোর কমান্ড

```bash
./scripts/restore-extensions.sh
```

---

## 📚 `install-apt.sh`

শুধুমাত্র APT Package Install করার জন্য।

সাধারণত আলাদাভাবে ব্যবহার করার প্রয়োজন হয় না।

---

## 🌐 `install-repos.sh`

অতিরিক্ত Repository যোগ করার জন্য ব্যবহৃত হয়।

সাধারণত আলাদাভাবে ব্যবহার করার প্রয়োজন হয় না।

---

## 🔗 `stow-all.sh`

শুধুমাত্র GNU Stow পুনরায় Apply করার জন্য।

সাধারণত `restore.sh` নিজেই এই কাজ করে।

---

# 📋 সংক্ষিপ্ত তালিকা

| স্ক্রিপ্ট | ব্যবহার |
|----------|----------|
| ⭐ `bootstrap.sh` | নতুন Linux Setup-এর জন্য (প্রধান Entry Point) |
| 💾 `backup.sh` | বর্তমান Configuration Backup করার জন্য |
| ♻️ `restore.sh` | সম্পূর্ণ Environment Restore করার জন্য |
| 🖥️ `restore-dconf.sh` | শুধুমাত্র GNOME Settings Restore করার জন্য |
| 🧩 `restore-extensions.sh` | শুধুমাত্র GNOME Extensions Restore করার জন্য |
| 📦 `install.sh` | `bootstrap.sh` দ্বারা ব্যবহৃত Internal Script |
| 📚 `install-apt.sh` | শুধুমাত্র APT Package Install |
| 🌐 `install-repos.sh` | অতিরিক্ত Repository Configure |
| 🔗 `stow-all.sh` | GNU Stow পুনরায় Apply |

---

# ✅ প্রস্তাবিত Workflow

## নতুন Linux Install করার পর

```bash
git clone https://github.com/Hafiz-Sakib/dotfiles.git

cd dotfiles

./scripts/bootstrap.sh
```

---

## Configuration পরিবর্তন করার পর

```bash
./scripts/backup.sh
```

---

## প্রয়োজনে সম্পূর্ণ Configuration Restore করতে

```bash
./scripts/restore.sh
```

---

> **নোট:** সাধারণ ব্যবহারকারীর জন্য মূলত দুটি স্ক্রিপ্টই যথেষ্ট—
>
> - ⭐ `./scripts/bootstrap.sh` → নতুন Linux Setup-এর জন্য
> - 💾 `./scripts/backup.sh` → পরিবর্তনগুলো Backup ও GitHub-এ সংরক্ষণের জন্য
>
> বাকি স্ক্রিপ্টগুলো Internal Utility Script হিসেবে রাখা হয়েছে এবং প্রয়োজন হলে আলাদাভাবে ব্যবহার করা যাবে।
