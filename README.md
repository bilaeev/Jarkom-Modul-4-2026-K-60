# Jarkom-Modul-4-2026-K-60
# Laporan Praktikum Modul 4 — Subnetting & Routing

**Komunikasi Data dan Jaringan Komputer 2026 | Kelompok K-60**

## Identitas dan Ruang Lingkup

| Komponen | Keterangan |
|---|---|
| Kelompok | K-60 |
| Prefix IP kelompok | `192.241.x.x` |
| Blok induk rancangan VLSM | `192.241.0.0/19` |
| Metode pada bagian ini | Variable Length Subnet Mask (VLSM) |
| Simulator | GNS3 |
| Router | `debinet` |
| Host | `alpinet` |
| Switch | Ethernet switch |
| NAT | Satu node NAT, tersambung langsung ke Cyberia |
| Jumlah subnet internal | 25: 15 jaringan LAN/host dan 10 jaringan penghubung router |

## 1. Topologi GNS3

<img width="1360" height="768" alt="WhatsApp Image 2026-11-05 at 19 55 23" src="https://github.com/user-attachments/assets/d49219ed-435e-4526-9549-c2e83aa0e293" />  


Topologi terdiri atas 13 router (`Cyberia`, `Wired`, `Navi`, `Tachibana`, `Psyche`, `Copland`, `Schumann`, `Accela`, `Deus`, `Protocol7`, `Knights`, `Phantoma`, dan `Shibuya`), 13 Ethernet switch, 25 node host, dan satu NAT. Router **Wired** menjadi simpul distribusi menuju cabang Navi, Tachibana, serta segmen bersama Switch2 (`Psyche`, `Copland`, `Schumann`).

<img width="1280" height="724" alt="WhatsApp Image 2026-11-05 at 19 55 32" src="https://github.com/user-attachments/assets/7d1e2bac-ca07-41aa-b605-3d7861bcc034" />  


## 2. Perencanaan dan Pembagian IPv4 VLSM

Alamat dialokasikan dari kebutuhan host terbesar ke terkecil. Untuk setiap LAN, prefix dipilih agar jumlah alamat *usable* mencukupi kebutuhan host ditambah satu interface gateway router. Koneksi point-to-point menggunakan `/30` (dua alamat usable). Segmen bersama Switch2 menggunakan `/29` untuk empat interface router.

**Ringkasan:** `192.241.0.0/19` mempunyai 8.192 alamat; total alokasi 25 subnet adalah **4.188 alamat**, tanpa subnet saling tumpang tindih. Sisa 4.004 alamat dalam blok induk belum dialokasikan. Kapasitas yang tertulis di bawah adalah **alamat usable**, bukan jumlah perangkat yang sungguh dibuat pada kanvas.

### 2.1 Tabel pembagian IP

<img width="1280" height="720" alt="WhatsApp Image 2026-11-05 at 19 55 39" src="https://github.com/user-attachments/assets/5c5e21e3-d04d-41f1-a047-dfe967e3c97c" />  


| Segmen | Network ID | Prefix | Netmask | Broadcast | Range usable | Usable |
|---|---|---|---|---|---|---:|
| Karl, Lin | `192.241.0.0` | `/22` | `255.255.252.0` | `192.241.3.255` | `192.241.0.1 – 192.241.3.254` | 1022 |
| Omnipresence, Denpa | `192.241.4.0` | `/22` | `255.255.252.0` | `192.241.7.255` | `192.241.4.1 – 192.241.7.254` | 1022 |
| Masayuki | `192.241.8.0` | `/23` | `255.255.254.0` | `192.241.9.255` | `192.241.8.1 – 192.241.9.254` | 510 |
| Collective, Ghost | `192.241.10.0` | `/23` | `255.255.254.0` | `192.241.11.255` | `192.241.10.1 – 192.241.11.254` | 510 |
| Alice, Reika | `192.241.12.0` | `/24` | `255.255.255.0` | `192.241.12.255` | `192.241.12.1 – 192.241.12.254` | 254 |
| Yasuo, Miho, Kuma | `192.241.13.0` | `/24` | `255.255.255.0` | `192.241.13.255` | `192.241.13.1 – 192.241.13.254` | 254 |
| JJ, MyuMyu | `192.241.14.0` | `/25` | `255.255.255.128` | `192.241.14.127` | `192.241.14.1 – 192.241.14.126` | 126 |
| Lilith, Specter | `192.241.14.128` | `/25` | `255.255.255.128` | `192.241.14.255` | `192.241.14.129 – 192.241.14.254` | 126 |
| Taro | `192.241.15.0` | `/26` | `255.255.255.192` | `192.241.15.63` | `192.241.15.1 – 192.241.15.62` | 62 |
| Juri | `192.241.15.64` | `/26` | `255.255.255.192` | `192.241.15.127` | `192.241.15.65 – 192.241.15.126` | 62 |
| Chisa, Hodgeson | `192.241.15.128` | `/26` | `255.255.255.192` | `192.241.15.191` | `192.241.15.129 – 192.241.15.190` | 62 |
| Lain, Mika | `192.241.15.192` | `/26` | `255.255.255.192` | `192.241.15.255` | `192.241.15.193 – 192.241.15.254` | 62 |
| Semi | `192.241.16.0` | `/27` | `255.255.255.224` | `192.241.16.31` | `192.241.16.1 – 192.241.16.30` | 30 |
| Switch2: Wired, Psyche, Copland, Schumann | `192.241.16.32` | `/29` | `255.255.255.248` | `192.241.16.39` | `192.241.16.33 – 192.241.16.38` | 6 |
| Akashic | `192.241.16.40` | `/29` | `255.255.255.248` | `192.241.16.47` | `192.241.16.41 – 192.241.16.46` | 6 |
| Eiri | `192.241.16.48` | `/29` | `255.255.255.248` | `192.241.16.55` | `192.241.16.49 – 192.241.16.54` | 6 |
| Cyberia – Wired | `192.241.16.56` | `/30` | `255.255.255.252` | `192.241.16.59` | `192.241.16.57 – 192.241.16.58` | 2 |
| Wired – Navi | `192.241.16.60` | `/30` | `255.255.255.252` | `192.241.16.63` | `192.241.16.61 – 192.241.16.62` | 2 |
| Wired – Tachibana | `192.241.16.64` | `/30` | `255.255.255.252` | `192.241.16.67` | `192.241.16.65 – 192.241.16.66` | 2 |
| Schumann – Accela | `192.241.16.68` | `/30` | `255.255.255.252` | `192.241.16.71` | `192.241.16.69 – 192.241.16.70` | 2 |
| Tachibana – Deus | `192.241.16.72` | `/30` | `255.255.255.252` | `192.241.16.75` | `192.241.16.73 – 192.241.16.74` | 2 |
| Deus – Protocol7 | `192.241.16.76` | `/30` | `255.255.255.252` | `192.241.16.79` | `192.241.16.77 – 192.241.16.78` | 2 |
| Protocol7 – Knights | `192.241.16.80` | `/30` | `255.255.255.252` | `192.241.16.83` | `192.241.16.81 – 192.241.16.82` | 2 |
| Knights – Phantoma | `192.241.16.84` | `/30` | `255.255.255.252` | `192.241.16.87` | `192.241.16.85 – 192.241.16.86` | 2 |
| Phantoma – Shibuya | `192.241.16.88` | `/30` | `255.255.255.252` | `192.241.16.91` | `192.241.16.89 – 192.241.16.90` | 2 |

### 2.2 Pohon pembagian IP

<img width="1600" height="800" alt="WhatsApp Image 2026-11-05 at 19 55 44" src="https://github.com/user-attachments/assets/85d383be-51ae-47a9-beb5-05cc86a724cf" />  


Pohon IP dibagi bertingkat menggunakan batas network biner yang benar; subnet `/22`, `/23`, `/24`, `/25`, `/26`, `/27`, `/29`, dan `/30` merupakan hasil akhir alokasi di atas. Cabang yang belum dialokasikan tidak dianggap LAN aktif.

## 3. Konfigurasi GNS3

Konfigurasi dijalankan pada console Linux masing-masing node melalui shell script di `/root`. Contoh perintah `ip addr` dan `ip route` merupakan konfigurasi **runtime**, sehingga dapat hilang setelah node dijalankan ulang. Karena itu, simpan script terpisah di repository untuk pemulihan.

### 3.1 Konfigurasi router: interface yang sudah diverifikasi

**Cyberia**

| Interface | Alamat IPv4 | Fungsi |
|---|---|---|
| `eth1` | `192.241.16.57/30` | Cyberia ↔ Wired |
| `eth2` | `192.241.14.1/25` | Gateway LAN JJ dan MyuMyu |

Ringkasan route Cyberia yang teramati:

```sh
ip route replace 192.241.0.0/19 via 192.241.16.58 dev eth1
```

**Wired**

| Interface | Alamat IPv4 | Fungsi |
|---|---|---|
| `eth0` | `192.241.16.58/30` | Menuju Cyberia |
| `eth1` | `192.241.16.61/30` | Menuju Navi |
| `eth2` | `192.241.16.65/30` | Menuju Tachibana |
| `eth3` | `192.241.16.33/29` | Segmen bersama Switch2 |

**Navi**

| Interface | Alamat IPv4 | Fungsi |
|---|---|---|
| `eth0` | `192.241.16.62/30` | Menuju Wired |
| `eth1` | `192.241.12.1/24` | Gateway Alice/Reika |
| `eth2` | `192.241.15.1/26` | Gateway Taro |
| `eth3` | `192.241.13.1/24` | Gateway Yasuo/Miho/Kuma |

**Router lainnya:** `Psyche`, `Copland`, `Schumann`, `Accela`, `Tachibana`, `Deus`, `Protocol7`, `Knights`, `Phantoma`, dan `Shibuya` dikonfigurasi berdasarkan tabel VLSM yang sama. Detail nomor interface dan route final per node sebaiknya diambil dari output `ip -br -4 addr` serta `ip -4 route show` masing-masing node, bukan diasumsikan dari gambar saja. File konfigurasi individual dapat dilihat pada direktori `GNS3-VLSM/scripts/routers/`.

### 3.2 Routing statis dan efisiensi

Routing menggunakan kombinasi **default route pada router cabang** dan **static route menuju subnet tujuan**. Pada router Wired, rute teramati setelah pengujian adalah sebagai berikut (rute yang terhubung langsung tidak dicantumkan pada potongan ini):

```text
default via 192.241.16.57 dev eth0
192.241.0.0/22 via 192.241.16.34 dev eth3
192.241.4.0/22 via 192.241.16.36 dev eth3
192.241.8.0/23 via 192.241.16.35 dev eth3
192.241.10.0/23 via 192.241.16.66 dev eth2
192.241.12.0/23 via 192.241.16.62 dev eth1
192.241.14.128/25 via 192.241.16.66 dev eth2
192.241.15.0/26 via 192.241.16.62 dev eth1
192.241.15.64/26 via 192.241.16.35 dev eth3
192.241.15.128/25 via 192.241.16.66 dev eth2
192.241.16.0/27 via 192.241.16.66 dev eth2
192.241.16.40/29 via 192.241.16.36 dev eth3
192.241.16.48/29 via 192.241.16.66 dev eth2
192.241.16.68/30 via 192.241.16.36 dev eth3
192.241.16.72/29 via 192.241.16.66 dev eth2
192.241.16.80/28 via 192.241.16.66 dev eth2
```

> Rute ringkasan seperti `192.241.12.0/23`, `192.241.15.128/25`, `192.241.16.72/29`, dan `192.241.16.80/28` digunakan ketika subnet yang dicakup memiliki next hop yang sama. Pengujian ping menunjukkan keterjangkauan, tetapi audit efisiensi final tetap perlu memastikan tidak ada prefix terlalu luas atau rute yang tidak perlu.

### 3.3 Konfigurasi host

Setiap host memakai satu interface `eth0`, IP statis sesuai tabel berikut, dan default gateway menuju router LAN-nya. Script konfigurasi yang digunakan dalam praktikum bernama `setup-host-k60.sh` dengan pemilihan konfigurasi berdasarkan `hostname`.

| Host | IP/Prefix | Default gateway |
|---|---|---|
| JJ | `192.241.14.2/25` | `192.241.14.1` |
| MyuMyu | `192.241.14.3/25` | `192.241.14.1` |
| Karl | `192.241.0.2/22` | `192.241.0.1` |
| Lin | `192.241.0.3/22` | `192.241.0.1` |
| Juri | `192.241.15.66/26` | `192.241.15.65` |
| Masayuki | `192.241.8.2/23` | `192.241.8.1` |
| Akashic | `192.241.16.42/29` | `192.241.16.41` |
| Omnipresence | `192.241.4.2/22` | `192.241.4.1` |
| Denpa | `192.241.4.3/22` | `192.241.4.1` |
| Alice | `192.241.12.2/24` | `192.241.12.1` |
| Reika | `192.241.12.3/24` | `192.241.12.1` |
| Taro | `192.241.15.2/26` | `192.241.15.1` |
| Yasuo | `192.241.13.2/24` | `192.241.13.1` |
| Miho | `192.241.13.3/24` | `192.241.13.1` |
| Kuma | `192.241.13.4/24` | `192.241.13.1` |
| Collective | `192.241.10.2/23` | `192.241.10.1` |
| Ghost | `192.241.10.3/23` | `192.241.10.1` |
| Lilith | `192.241.14.130/25` | `192.241.14.129` |
| Specter | `192.241.14.131/25` | `192.241.14.129` |
| Chisa | `192.241.15.130/26` | `192.241.15.129` |
| Hodgeson | `192.241.15.131/26` | `192.241.15.129` |
| Eiri | `192.241.16.50/29` | `192.241.16.49` |
| Semi | `192.241.16.2/27` | `192.241.16.1` |
| Lain | `192.241.15.194/26` | `192.241.15.193` |
| Mika | `192.241.15.195/26` | `192.241.15.193` |

Contoh restore host:

```sh
sh /root/setup-host-k60.sh
ip -br -4 addr
ip route
```

Contoh restore router (nama script disesuaikan dengan node):

```sh
sh /root/setup-cyberia.sh
sh /root/setup-wired.sh
# Pada router lain, gunakan setup-<nama-router>.sh atau setup-k60.sh
# jika file tersebut memang tersedia dan cocok dengan hostname node.
```

**Penting:** rute yang ditambahkan manual setelah script awal dijalankan harus ikut disimpan pada script final. Validasi isi file dengan `cat`/`sh -n` dan cocokan dengan routing aktif sebelum mengumpulkannya.

## 4. Pengujian Konektivitas

### 4.1 Ping gateway dan antar-LAN

Pengujian dilakukan menggunakan `ping -c 3 <IP-tujuan>` pada console GNS3. Hasil yang dilaporkan pada praktikum:

| Sumber | Tujuan | IP tujuan | Hasil |
|---|---|---|---|
| JJ | Alice | `192.241.12.2` | 3/3, 0% loss |
| Karl | Omnipresence | `192.241.4.2` | 3/3, 0% loss |
| Alice | Collective | `192.241.10.2` | 3/3, 0% loss |
| Lain | JJ | `192.241.14.2` | 3/3, 0% loss |
| Semi | Lain | `192.241.15.194` | 3/3, 0% loss |

### 4.2 Pengujian 24 tujuan dari JJ

Script `test-all-k60.sh` melakukan ping sekali ke setiap host lain dari JJ. Hasil akhir:

```text
BERHASIL : 24
GAGAL   : 0
```

Artinya seluruh **24 host tujuan dapat dijangkau dari JJ** pada saat pengujian, bukan bukti bahwa setiap kemungkinan pasangan host atau setiap interface router sudah diuji dua arah.

## 5. Analisis Hasil (VLSM)

1. **Pengalamatan:** seluruh 25 subnet berada dalam blok induk `192.241.0.0/19` dan tidak saling overlap.
2. **Efisiensi subnet:** prefix LAN dipilih menurut kebutuhan host dan kapasitas usable; link point-to-point menggunakan `/30`, sedangkan subnet bersama Switch2 menggunakan `/29`.
3. **Routing:** sebagian rute disederhanakan menggunakan summary route dan default route. Karena routing aktual dibuat melalui script serta beberapa perbaikan manual, sinkronisasi script final dengan `ip route` diperlukan sebelum penilaian.
4. **Konektivitas:** pengujian dari JJ ke 24 host lain menunjukkan 24 keberhasilan dan 0 kegagalan.
5. **Persistensi:** konfigurasi menggunakan `ip` bersifat runtime; setelah node pernah dimulai ulang, IP perlu dipulihkan dengan script. Penyimpanan script dan backup project perlu dilakukan sebelum menutup praktikum.

