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
- untuk menghapus dapat menggunakan method `delete()` untuk menghapus berdasarkan `key`, `clear()` untuk menghapus seluruh isi box, `deleteFromDisk()` untuk menghapus box dari lokal disk, dsb.<br>

## Custom Object ke box HiveDB
![image](https://github.com/user-attachments/assets/d9061fde-f96f-4feb-b337-edb83c833df2)

Pada program saya membuat class bernama `User` pada file `user.dart`. Class ini digunakan untuk menyimpan data dari user yang meliputi `name`, `age`, `occupation`, dan `email` menjadi objek. Jadi saya buat sedemikian rupa agar dapat ditampilkan dengan rapi dalam tabel di mana terdapat 4 kolom data user yang telah disebutkan. Untuk setiap instance objek akan ditampilkan sebagai row pada tabel.
1. Buat custom class untuk menyimpan data user
```dart
class User extends HiveObject{
  late String name;
  late int age;
  late String occupation;
  late String email;

  User({required this.name, required this.age, required this.occupation, required this.email});
}
```
2. Mendefinisikan HiveType pada class dan HiveField pada field properties,  membuat hive adapter dari class User (UserAdapter)
```dart
import 'package:hive/hive.dart';

part 'user.g.dart';   // digenerate otomatis ketika jalankan command:
                      // `dart run build_runner build`

@HiveType(typeId: 0)
class User extends HiveObject{
  @HiveField(0)
  late String name;
  
  @HiveField(1)
  late int age;
  
  @HiveField(2)
  late String occupation;

  @HiveField(3)
  late String email;

  User({required this.name, required this.age, required this.occupation, required this.email});
}
```
pendefinisian ini dilakukan untuk membuat adapter Hive pada step berikutnya, di mana dilakukan untuk memberi tahu code‑gen bagaimana memetakan field ke byte.<br>

`part 'user.g.dart';` merupakan line yang akan menggabungkan isi program `user.dart` dengan `user.g.dart` di mana `user.g.dart` merupakan Adapter dari class User yang akan digenerate secara otomatis dengan cara menjalankan command line pada terminal berikut
```
dart run build_runner build
```
setelah menjalankan command tersebut maka akan secara otomatis terbuat Hive Adapter bernama `UserAdapter` yang disimpan pada file `user.g.dart`, langkah ini diperlukan agar bisa melakukan penyimpanan objek 'kompleks' ke dalam HiveDB

3. Ubah pendekatan pembuatan box pada fungsi main dan stateful widget home
```dart
void main() async{
  // ...
  var box = await Hive.openBox<User>('boxing');
  // ...
}
//..
class _HomeState extends State<Home> {
  // ...
  final _box = Hive.box<User>('boxing');
  // ...
}
```
4. Buat tombol `write` agar dapat mengisikan data sesuai dengan field kemudian buat tabel untuk memparsing/mapping data box user
```
// kode ada di lib/main.dart
```
![image](https://github.com/user-attachments/assets/aaf226da-e04d-4233-b16b-f8bc268e06da)
