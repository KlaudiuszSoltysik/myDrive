import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'log-in-provider.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, statusBarColor: Colors.white));

    return ChangeNotifierProvider<GoogleSignInProvider>(
      create: (_) => GoogleSignInProvider(),
      builder: (context, child) {
        return Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset('assets/images/car.png'),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'myDrive',
                          style: GoogleFonts.racingSansOne(
                              color: Colors.blue[700]),
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Provider.of<GoogleSignInProvider>(context, listen: false)
                        .googleLogIn(context);
                  },
                  label: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  icon: FaIcon(FontAwesomeIcons.google),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue[700]!),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
