# DevSync // Tech Hub — Flutter Mini App (P03)

## 1. Deskripsi Aplikasi
**DevSync // Tech Workspace** adalah aplikasi mobile Flutter bertema *Modern Cyberpunk / Futuristic Tech Ecosystem* dengan 3 layar yang mensimulasikan manajemen modul dan arsitektur komputasi mutakhir (AI, Cloud & DevOps, Cyber Security, Mobile IoT).

Aplikasi ini memenuhi seluruh kriteria penugasan P03:
1. **Layar Utama (`ItemListScreen`)**:
   - `StatefulWidget` yang menampilkan daftar modul komputasi aktif menggunakan `ListView.builder`.
   - Menggunakan `setState` yang bereaksi secara instan saat modul baru dideploy dari form.
   - Dilengkapi kartu modern bernuansa *dark slate* dengan aksen neon glow (Cyan `#38BDF8`, Indigo `#818CF8`, Rose `#F43F5E`).
2. **Layar Form Deploy Modul (`AddItemScreen`)**:
   - Form futuristik dengan **tiga jenis masukan berbeda**:
     - `TextFormField` (Module Identifier & Technical Specification).
     - `DropdownButtonFormField` (Architecture Domain: AI & Data Science, Cloud & DevOps, Cyber Security, Mobile & IoT).
     - `SwitchListTile` (Severity Flag: High Priority / Production Ready).
   - Validasi ketat yang menolak masukan kosong atau data tidak valid.
   - Menggunakan `setState` pada perubahan switch dan pilihan dropdown.
   - Mengirim objek modul kembali ke layar utama secara asynchronous menggunakan `Navigator.pop(context, newItem)`.
3. **Layar Detail & Telemetri (`ItemDetailScreen`)**:
   - Menampilkan spesifikasi teknis lengkap serta status *telemetry diagnosis* dari modul yang dipilih.
   - Menggunakan kembali widget kustom `CustomItemCard` dalam mode detail.
   - Menyediakan navigasi dua arah kembali ke layar hub (`Navigator.pop`).

---

## 2. Struktur Proyek
Sesuai prinsip arsitektur Flutter yang modular (Bab 4):
```text
lib/
├── main.dart                  # Konfigurasi Tema Dark Cyber & Routing MaterialApp
├── models/
│   └── item.dart              # Model domain modul teknologi
├── screens/
│   ├── item_list.dart         # Layar 1: Hub daftar modul (StatefulWidget + setState)
│   ├── item_detail.dart       # Layar 2: Detail telemetri & arsitektur modul
│   └── add_item.dart          # Layar 3: Form deploy modul (Validasi multi-input)
└── widgets/
    └── custom_item_card.dart  # Reusable Cyberpunk Glass Card Widget
```

---

## 3. Catatan Debugging: Bug yang Sempat Membuat Mentok

### Deskripsi Bug:
Saat data modul baru ditambahkan pada layar `AddItemScreen` dan form berhasil divalidasi, navigasi berhasil kembali ke layar daftar, namun **item baru tidak langsung muncul di daftar** kecuali aplikasi di-hot reload secara manual.

### Cara Menemukan Masalah:
1. Saya memeriksa siklus hidup navigasi route pada Flutter. Ketika `Navigator.pushNamed` dijalankan, fungsi tersebut mengembalikan sebuah `Future` yang mewakili nilai kembalian dari route berikutnya.
2. Kode awal hanya mengeksekusi navigasi tanpa menunggu nilai kembali (`await`), sementara layar penampung tidak memanggil `setState` untuk me-render ulang list.

### Solusi & Perbaikan:
1. Pada `AddItemScreen`, tombol simpan mengirim objek `Item` baru melalui pop argument:
   ```dart
   Navigator.pop(context, newItem);
   ```
2. Pada `ItemListScreen`, fungsi pemanggil diubah menjadi async-await dan menyisipkan item baru langsung ke dalam `setState`:
   ```dart
   final newItem = await Navigator.pushNamed(context, '/add');
   if (newItem != null && newItem is Item) {
     setState(() {
       _items.insert(0, newItem);
     });
   }
   ```
Dengan solusi ini, prinsip *state placement* berada pada lokasi yang ideal (tidak terlalu tinggi dan tidak terlalu rendah), dan UI langsung me-rebuild secara instan begitu navigasi kembali.
