import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {

  await Hive.initFlutter();

  var box = await Hive.openBox('boxing');

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

  final _box = Hive.box('boxing');

  void ngeread(){
    print(_box.get(1));
  }

  void ngewrite(){
    _box.put(1, "sairul");
  }

  void ngedelete(){
    _box.delete(1);
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
