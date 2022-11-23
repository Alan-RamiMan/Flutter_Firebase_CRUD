import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/pages/addpage.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/listpages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FreeCode Spot',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         brightness: Brightness.dark,
//       ),
//       home: AddPage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Arquetipo",
      initialRoute: 'home',
      debugShowCheckedModeBanner: false,
      routes: {
        'home': (BuildContext contexto) => Home(),
        'addPersona': (BuildContext contexto) => AddPage(),
        'listPersonas': (BuildContext contexto) => ListPage(),
      },
    );
  }
}
