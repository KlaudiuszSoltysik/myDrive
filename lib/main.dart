import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'log-in-screen.dart';
import 'main-screen.dart';
import 'add-vehicle-screen.dart';
import 'add-event-screen.dart';
import 'edit-event-screen.dart';
import 'edit-vehicle-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');

  runApp(
    MaterialApp(
      initialRoute: email == null ? '/' : '/main-screen',
      routes: {
        '/': (context) => LogInScreen(),
        '/main-screen': (context) => MainScreen(),
        '/add-vehicle-screen': (context) => AddVehicleScreen(),
        '/edit-vehicle-screen': (context) => EditVehicleScreen(),
        '/add-event-screen': (context) => AddEventScreen(),
        '/edit-event-screen': (context) => EditEventScreen(),
      },
      title: 'myDrive',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue[700],
          fontFamily: 'Montserrat'),
    ),
  );
}
