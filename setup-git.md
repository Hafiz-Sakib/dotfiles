# 🔧 Git ও GitHub Setup Guide

`setup-git.sh` একটি ইন্টারঅ্যাকটিভ (Interactive) স্ক্রিপ্ট, যা নতুন Linux সিস্টেমে Git এবং GitHub-এর প্রাথমিক সেটআপ সহজ ও দ্রুত সম্পন্ন করার জন্য তৈরি করা হয়েছে।

এই স্ক্রিপ্টটি এমনভাবে ডিজাইন করা হয়েছে যাতে যে কেউ নিজের GitHub অ্যাকাউন্ট ব্যবহার করে নিরাপদভাবে Git কনফিগার করতে পারে। কোনো ব্যক্তিগত তথ্য বা অ্যাকাউন্টের তথ্য স্ক্রিপ্টে সংরক্ষিত থাকে না।

---

# ✨ কী কী কাজ করে?

স্ক্রিপ্টটি ধাপে ধাপে নিচের কাজগুলো সম্পন্ন করে—

- Git ইনস্টল আছে কিনা পরীক্ষা করে
- Git না থাকলে স্বয়ংক্রিয়ভাবে ইনস্টল করে (সমর্থিত Distribution-এ)
- GitHub CLI (`gh`) ইনস্টল আছে কিনা পরীক্ষা করে
- প্রয়োজন হলে GitHub CLI ইনস্টল করার সুযোগ দেয়
- Git Username ইনপুট নেয়
- Git Email ইনপুট নেয়
- Email যাচাই (Validation) করে
- Git Global Configuration সেট করে
- প্রয়োজনে নতুন SSH Key তৈরি করে
- GitHub CLI-এর মাধ্যমে GitHub Login করতে সাহায্য করে
- Authentication সফল হয়েছে কিনা পরীক্ষা করে
- SSH Public Key দেখায়
- GitHub-এর SSH Keys পেজে যুক্ত করার নির্দেশনা দেয়
- সবশেষে সম্পূর্ণ Configuration-এর সারসংক্ষেপ (Summary) দেখায়

---

# 🚀 কীভাবে ব্যবহার করবেন?

প্রথমে স্ক্রিপ্টটিকে Executable করুন—

```bash
chmod +x scripts/setup-git.sh
```

তারপর চালান—

```bash
./scripts/setup-git.sh
```

---

# 📝 স্ক্রিপ্ট চলাকালীন কী কী জিজ্ঞাসা করবে?

## ১. Git Username

উদাহরণ:

```text
Git Username: Hafiz Sakib
```

এটি আপনার Commit-এর Author Name হিসেবে ব্যবহৃত হবে।

---

## ২. Git Email

উদাহরণ:

```text
Git Email: hafizsakib5@gmail.com
```

এই Email-টি আপনার GitHub Account-এর Email হওয়াই উত্তম।

---

## ৩. SSH Key তৈরি করবেন কি?

যদি আগে SSH Key তৈরি না করে থাকেন, তাহলে স্ক্রিপ্ট জিজ্ঞাসা করবে—

```text
Generate SSH key? (Y/n)
```

`Y` চাপলে নতুন SSH Key তৈরি হবে।

---

## ৪. GitHub Authentication

যদি GitHub CLI ইনস্টল থাকে, তাহলে Authentication Method নির্বাচন করতে পারবেন।

দুটি অপশন থাকবে—

### Browser Login (Recommended)

এটি GitHub-এর অফিসিয়াল ও সবচেয়ে নিরাপদ পদ্ধতি।

Browser খুলবে।

তারপর—

- GitHub-এ Login করবেন
- অনুমতি (Authorize) দেবেন
- Login সম্পন্ন হবে

---

### Personal Access Token (PAT)

যাদের আগে থেকেই GitHub Personal Access Token আছে, তারা এই অপশন ব্যবহার করতে পারবেন।

---

# 🔐 নিরাপত্তা (Security)

অনেকেই মনে করেন—

Git Username এবং Email সেট করলেই GitHub Account Login হয়ে যায়।

**এটি সম্পূর্ণ ভুল ধারণা।**

Git Username এবং Email শুধুমাত্র Commit-এর Author Information।

এগুলো কোনোভাবেই GitHub Account-এর Access দেয় না।

উদাহরণ—

```bash
git config --global user.name "Hafiz Sakib"

git config --global user.email "hafizsakib5@gmail.com"
```

এতে শুধুমাত্র Commit-এর Author পরিবর্তন হবে।

কিন্তু—

- Private Repository Access পাওয়া যাবে না
- Git Push করা যাবে না
- GitHub Account Login হবে না

---

# GitHub Authentication কোথায় হয়?

GitHub Authentication সম্পূর্ণ আলাদা একটি প্রক্রিয়া।

এটি হতে পারে—

- GitHub CLI Login
- SSH Key
- Personal Access Token (PAT)

এই তিনটির যেকোনো একটি ছাড়া GitHub Repository-তে Push করা সম্ভব নয়।

---

# কেন Browser Login লাগে?

GitHub ইচ্ছাকৃতভাবেই Browser Authorization ব্যবহার করে।

এর ফলে—

- কোনো Script আপনার অজান্তে GitHub Account-এ Login করাতে পারে না।
- আপনার অনুমতি ছাড়া Private Repository Access পাওয়া সম্ভব নয়।
- OAuth Security বজায় থাকে।

এটি GitHub-এর নিরাপত্তা ব্যবস্থার অংশ।

---

# SSH Key কী?

SSH Key দুটি অংশ নিয়ে গঠিত—

## Public Key

এটি GitHub-এ যোগ করা হয়।

এটি সবার সাথে শেয়ার করা নিরাপদ।

---

## Private Key

এটি শুধুমাত্র আপনার কম্পিউটারে থাকে।

**কখনোই কারও সাথে শেয়ার করবেন না।**

Private Key-ই আপনার পরিচয় প্রমাণ করে।

---

# Script কী কী পরিবর্তন করে?

স্ক্রিপ্টটি Git Global Configuration-এ নিচের সেটিংগুলো যুক্ত করে—

```text
user.name
user.email
init.defaultBranch
pull.rebase
core.editor
```

এছাড়া প্রয়োজনে—

- SSH Key তৈরি করে
- GitHub CLI Login চালু করে

---

# Script কী করে না?

নিরাপত্তার স্বার্থে স্ক্রিপ্টটি কখনো—

- GitHub Password সংরক্ষণ করে না
- Personal Access Token সংরক্ষণ করে না
- আপনার SSH Private Key আপলোড করে না
- GitHub Account-এ জোরপূর্বক Login করায় না
- কোনো ব্যক্তিগত তথ্য Repository-তে সংরক্ষণ করে না

---

# কারা ব্যবহার করতে পারবেন?

এই স্ক্রিপ্টটি—

- নতুন Linux User
- Developer
- Fresh Linux Installation
- Virtual Machine
- নতুন Laptop
- নতুন Desktop

সব ক্ষেত্রেই ব্যবহার করা যাবে।

প্রত্যেক ব্যবহারকারী নিজের Git Username এবং Email প্রদান করবেন।

অন্য কারও GitHub Account-এর কোনো তথ্য ব্যবহার হবে না।

---

# সাধারণ Workflow

নতুন Linux Install করার পর—

```bash
git clone https://github.com/Hafiz-Sakib/dotfiles.git

cd dotfiles

./scripts/bootstrap.sh

./scripts/setup-git.sh
```

এরপর—

```bash
git clone <your-repository>

git add .

git commit -m "Initial commit"

git push
```

সবকিছু প্রস্তুত।

---

# 📌 সংক্ষেপে

| বিষয় | অবস্থা |
|--------|---------|
| Git Install | ✅ |
| GitHub CLI Install | ✅ |
| Git Configuration | ✅ |
| Email Validation | ✅ |
| SSH Key Generate | ✅ |
| GitHub Login | ✅ (User Authorization Required) |
| Authentication Verify | ✅ |
| SSH Public Key Display | ✅ |
| নিরাপদ (Safe) | ✅ |

---

# 💡 নোট

এই স্ক্রিপ্টটি GitHub-এর অফিসিয়াল নিরাপত্তা নীতিমালা অনুসরণ করে তৈরি করা হয়েছে।

GitHub Account-এর Authentication সম্পূর্ণভাবে ব্যবহারকারীর অনুমতির উপর নির্ভরশীল। স্ক্রিপ্টটি কখনোই আপনার অনুমতি ছাড়া GitHub Account-এ Login করার চেষ্টা করবে না।
