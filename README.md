Tutorial Aplikasi CRUD untuk yg mau mengenal Meteor Framework

### Tutorial apa ini?

Teman2 yang sudah lama bermain di bidang web development tentunya sudah akrab dengan nama2 seperti PHP, MYSQL, OOP, HTML, CSS, Bootstrap, CPanel, Framework CodeIgniter, Yii, Laravel, dan banyak lagi yg lainnya. Dan dari banyak item yang disebutkan tadi, mungkin hanya bootstrap yg tetap akan terpakai.
Mengapa Meteor begitu berbeda dari framework PHP? Dan apa aja yg bisa ditawarkan Meteor untuk masa depan web dev? Singkat kata,
> Meteor adalah framework js untuk multi-platform

Yang artinya, cukup dengan 1 basis kode, aplikasi kita nantinya bisa dikonversi ke format yg lain seperti Android .apk, iOS xcode, dan kalau dikombinasi dengan lib Electron bisa jadi .exe Dan dalam tutorial ini kita hanya akan menggunakan 2 format file, yaitu .coffee dan .jade Bahkan nanti kalau teman2 sudah lebih mahir, tetap 2 file tadi juga yg akan dominan. Dan jika masih penasaran tentang kemampuan Meteor untuk dev masa depan, silahkan kunjungi repo Meteor Awesome

### Yang dibutuhkan

Kemungkinan besar teman2 yg kunjungi repo ini menggunakan Windows 7 - 10 Tentu Meteor juga menyediakan frameworknya dalam versi windows, namun sejauh pengalaman penulis,
***versi linux dan mac JAUH lebih baik***. Teman2 bisa kunjungi website meteor.com dan download .exe nya atau kalau dari terminal linux dan mac lakukan
```
curl https://install.meteor.com/ | sh 
```
Secara otomatis teman2 akan mendapatkan framework Meteor seri terbaru (biasanya diupdate mingguan oleh MDG) Frameworknya sendiri cukup ringan, 100an Mb. Tapi seiring waktu bobotnya akan semakin besar. Saat tulisan ini dibuat, folder Meteor penulis sudah memenuhi ruang 12,4 GB (What The??). Tapi itu dikarenakan penulis mencoba banyak repo dan banyak sisa2 lib repo yg belum dibuang. Tapi tenang saja, rata2 folder project hanya berkisar 50 - 100 Mb Setelah instalasi meteor berhasil, teman2 bisa lanjut ke sesi Tutorial nya

# Tutorialnya
