import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'log-in-screen.dart';
import 'main-screen.dart';
import 'add-vehicle-screen.dart';
import 'add-event-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LogInScreen(),
        '/main-screen': (context) => MainScreen(),
        '/add-vehicle-screen': (context) => AddVehicleScreen(),
        '/add-event-screen': (context) => AddEventScreen(),
      },
      title: 'myDrive',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue[700],
          fontFamily: 'Montserrat'),
    ),
  );
}
