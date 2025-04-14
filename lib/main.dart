import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'user.dart';

void main() async {

  // initialize hivedb
  await Hive.initFlutter();

  // register adapter agar objek user bisa masuk ke box hivedb
  Hive.registerAdapter(UserAdapter());
  // box dengan datatype User
  var box = await Hive.openBox<User>('boxing');

  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _box = Hive.box<User>('boxing');

  void ngeread(){
    // print(_box.get(1));
    // print(_box);

    // final all = _box.toMap();
    // print(all);

    print(_box.get(1)?.name);
    print(_box.get(1)?.age);
    print(_box.get(1)?.occupation);
    print(_box.get(1)?.email);
  }

  void ngewrite(){
    // _box.put(1, "sairul");
    // _box.add("sairul");
    final user = User(name: 'sairul', age: 21, occupation: 'student', email: "sairul@gmail.com");
    _box.put(1, user);
  }

  void ngedelete(){
    // _box.delete(1);
    _box.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Exploring HiveDB"),),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
                onPressed: ngeread,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  "read",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white
                  ),
                )
            ),
            TextButton(
                onPressed: ngewrite,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  "write",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white
                  ),
                )
            ),
            TextButton(
                onPressed: ngedelete,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: Text(
                  "delete",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
