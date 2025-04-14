// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'user.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   late final Box<User> _box;
//
//   @override
//   void initState() {
//     super.initState();
//     _box = Hive.box<User>('boxing');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Text("Exploring HiveDB")),
//         backgroundColor: Colors.amber,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // ... tombol read/write/delete-mu di sini ...
//
//             const SizedBox(height: 24),
//
//             // DYNAMIC TABLE
//             Expanded(
//               child: ValueListenableBuilder<Box<User>>(
//                 valueListenable: _box.listenable(),
//                 builder: (context, box, _) {
//                   // jika kosong, tampilkan pesan
//                   if (box.isEmpty) {
//                     return const Center(child: Text("Box masih kosong"));
//                   }
//
//                   // ambil semua User sebagai List
//                   final users = box.values.toList();
//
//                   return SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Table(
//                       border: TableBorder.all(),
//                       defaultColumnWidth: const IntrinsicColumnWidth(),
//                       children: [
//                         // HEADER ROW
//                         const TableRow(
//                           decoration: BoxDecoration(color: Colors.grey),
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Text("Age", style: TextStyle(fontWeight: FontWeight.bold)),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Text("Occupation", style: TextStyle(fontWeight: FontWeight.bold)),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
//                             ),
//                           ],
//                         ),
//                         // DATA ROWS
//                         for (var user in users)
//                           TableRow(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8),
//                                 child: Text(user.name),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8),
//                                 child: Text(user.age.toString()),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8),
//                                 child: Text(user.occupation),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8),
//                                 child: Text(user.email),
//                               ),
//                             ],
//                           ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
