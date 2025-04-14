import 'package:hive/hive.dart';

part 'user.g.dart';   // digenerate otomatis ketika jalankan command:
                      // `flutter pub run build_runner build`

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