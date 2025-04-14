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

    final all = _box.toMap();
    print(all);

    print(_box.get(0)?.name);
    print(_box.get(0)?.age);
    print(_box.get(0)?.occupation);
    print(_box.get(0)?.email);
  }

  void ngewrite(String name, int age, String occupation, String email){
    // _box.put(1, "sairul");
    // _box.add("sairul");
    // final user = User(name: 'sairul', age: 21, occupation: 'student', email: "sairul@gmail.com");
    final user = User(name: name, age: age, occupation: occupation, email: email);
    _box.add(user);
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
                onPressed: () {
                  // ngewrite('sairul', 21, 'student', 'sairul@gmail.com');
                  final nameController = TextEditingController(text: "");
                  final ageController = TextEditingController(text: "");
                  final occupationController = TextEditingController(text: "");
                  final emailController = TextEditingController(text: "");
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        content: Column(
                          children: [
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "Name"
                              ),
                            ),
                            SizedBox(height: 12,),
                            TextField(
                              controller: ageController,
                              decoration: InputDecoration(
                                labelText: "Age"
                              ),
                            ),
                            SizedBox(height: 12,),
                            TextField(
                              controller: occupationController,
                              decoration: InputDecoration(
                                labelText: "Occupation"
                              ),
                            ),
                            SizedBox(height: 12,),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email"
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel", style: TextStyle(color: Colors.orange),),
                          ),
                          TextButton(
                            onPressed: () {
                              int age = int.parse(ageController.text);
                              // onConfirm.call();
                              ngewrite(
                                  nameController.text,
                                  age,
                                  occupationController.text,
                                  emailController.text);
                              Navigator.pop(context);
                            },
                            child: Text("Save", style: TextStyle(color: Colors.orange),),
                          ),
                        ],
                      );
                    }
                  );
                },
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
            SizedBox(height: 24,),
            // DYNAMIC TABLE
            Expanded(
              child: ValueListenableBuilder<Box<User>>(
                valueListenable: _box.listenable(),
                builder: (context, box, _) {
                  // jika kosong, tampilkan pesan
                  if (box.isEmpty) {
                    return const Center(child: Text("Box masih kosong"));
                  }

                  // ambil semua User sebagai List
                  final users = box.values.toList();

                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      border: TableBorder.all(),
                      defaultColumnWidth: const IntrinsicColumnWidth(),
                      children: [
                        // HEADER ROW
                        const TableRow(
                          decoration: BoxDecoration(color: Colors.grey),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Age", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Occupation", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        // DATA ROWS
                        for (var user in users)
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(user.name),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(user.age.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(user.occupation),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(user.email),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
