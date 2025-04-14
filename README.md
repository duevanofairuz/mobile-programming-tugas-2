# mobile-programming-tugas-2
**Exploring HiveDB in Flutter**

| NRP        | Nama                  |
|------------|-----------------------|
| 5025211052 | Duevano Fairuz Pandya |

## Quickstart Penggunaan HiveDB di Flutter
HiveDB adalah database NoSQL key–value yang ringan, cepat, dan mudah digunakan untuk penyimpanan data lokal di aplikasi Flutter/Dart.<br>
1. Tambahkan dependensi HiveDB ke pubspec.yaml
```yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  hive_generator: ^1.1.3
  build_runner: ^2.1.11
```
2. Ubah fungsi main menjadi asynchronus kemudian inisialisasi Hive secara asinkron menggunakan await
```dart
void main() async {

  // initialize hivedb
  await Hive.initFlutter();

  runApp(const MaterialApp(
    home: Home(),
  ));
}
```
pastikan untuk menggunakan stateful widget pada property home agar nanti data dapat diubah saat runtime


3. Buat box Hive
```dart
var box = await Hive.openBox('[nama_box]');
```
contoh: `var box = await Hive.openBox('boxing');`, nama dari box nanti akan diassign ke variable dalam class stateful widget

4. Assign box yang telah dibuat ke dalam stateful widget agar bisa digunakan
```dart
class _HomeState extends State<Home> {
  final _box = Hive.box('boxing');

  @override
  Widget build(BuildContext context) {
    return Scaffold(...)
  }
}
```
variable `_box` akan digunakan untuk mengakses box HiveDB yang telah dibuat

5. HiveDB basic operation
- untuk menambahkan data (add/create) dapat dilakukan dengan memanggil method `put` atau `add`, contoh penggunaan put: `_box.put(1, "sairul");` di mana parameter pertama adalah `key` dan parameter kedua dapat berupa berbagai data seperti `String`, `integer`, `List`, dsb. Untuk method `add` akan menambahkan data secara otomatis berdasarkan increment sehingga cukup mengisi parameter data nya saja, contoh penggunaan `_box.add("sairul")`
- untuk read dapat dilakukan dengan memanggil method `get`, contoh `_box.get(0)` di mana parameter nya adalah `key` dari data yang dituju
- untuk menghapus dapat menggunakan method `delete()` untuk menghapus berdasarkan `key`, `clear()` untuk menghapus seluruh isi box, `deleteFromDisk()` untuk menghapus box dari lokal disk, dsb.

## Custom Object ke box HiveDB

