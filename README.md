# 📦 Tar Utilities

A set of simple Bash scripts for creating and extracting `.tar` and `.tar.gz` archives.

---

## 🚀 Scripts

### 🗜️ `make_tar.sh` — Create a `.tar` archive

```bash
chmod +x make_tar.sh
./make_tar.sh directory
```

Creates an uncompressed `.tar` archive from the given directory.

---

### 🗜️💨 `make_targz.sh` — Create a `.tar.gz` archive

```bash
chmod +x make_targz.sh
./make_targz.sh directory
```

Creates a compressed `.tar.gz` archive from the given directory.

---

### 📂 `extract_tar.sh` — Extract an archive

```bash
chmod +x extract_tar.sh
./extract_tar.sh archive.tar
```

```bash
./extract_tar.sh archive.tar.gz
```

Supports both `.tar` and `.tar.gz` files.

---

### 📦 `make_7z.sh` — Create a `.7z` archive

```bash
chmod +x make_7z.sh
./make_7z.sh directory
```

Creates a compressed `.7z` archive from the given directory. Requires `7-Zip` (`sudo apt install 7zip`).

---

### 🔐 `make_7z_passwd.sh` — Create a password-protected `.7z` archive

```bash
chmod +x make_7z_passwd.sh
./make_7z_passwd.sh directory
```

Creates an encrypted `.7z` archive with AES-256 encryption. You will be prompted for a password. File names inside the archive are encrypted as well.

---

### 📂 Extract a `.7z` archive

```bash
7z x archive.7z
```

Works for both encrypted and unencrypted archives — if the archive is password-protected, you will be prompted for a password.

---


## 📋 Format Comparison

| Format    | Script                 | Compression | Encryption   | Size     |
|-----------|------------------------|-------------|--------------|----------|
| `.tar`    | `make_tar.sh`          | ❌ None     | ❌           | Larger   |
| `.tar.gz` | `make_targz.sh`        | ✅ gzip     | ❌           | Smaller  |
| `.7z`     | `make_7z.sh`           | ✅ LZMA2    | ❌           | Smallest |
| `.7z`     | `make_7z_passwd.sh`    | ✅ LZMA2    | ✅ AES-256   | Smallest |
