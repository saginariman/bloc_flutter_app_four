import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Authentication.dart';
import 'Error.dart';
import 'Mapping.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      // ignore: missing_return
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            title: 'Block App',
            theme: ThemeData(
              primaryColor: Colors.black,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: SomethingWentWrong(),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Block App',
            theme: ThemeData(
              primaryColor: Colors.black,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: MappingPage(auth: Auth(),),
          );
        }

        return Loading();
      },
    );
  }
// This widget is the root of your application.

}

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Block App',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(
        alignment: Alignment.center,
        child: Text('Loading'),
      )
    );
  }


}




