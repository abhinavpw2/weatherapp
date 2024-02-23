import 'package:flutter/material.dart';
import 'package:statefulapp/form.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "form",
      theme: ThemeData.light(),
      home: MyForm(),
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Stateful Widget".toUpperCase()),
//           centerTitle: true,
//         ),
//         body: MyStatefullApp(),
//       ),
//     );
//   }
// }

// class MyStatefullApp extends StatefulWidget {
//   const MyStatefullApp({super.key});

//   @override
//   State<MyStatefullApp> createState() => _MyStatefullAppState();
// }

// class _MyStatefullAppState extends State<MyStatefullApp> {
//   bool liked = false;

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         ListTile(
//           leading: Icon(Icons.token),
//           title: Text("NIKE SHOES"),
//           subtitle: Text("2.5 lakh ke joote"),
//           trailing: IconButton(
//             icon: liked ? (Icon(Icons.favorite,color: Colors.red,)) : (Icon(Icons.favorite_border)),
//             onPressed: () {
//               setState(() => liked = !liked);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
