import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'myDrive',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue[700],
          fontFamily: 'Montserrat',
        ),
        home: Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'myDrive',
                      style: GoogleFonts.racingSansOne(color: Colors.blue[700]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
