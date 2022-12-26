import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GoogleSignInProvider extends ChangeNotifier {
  late String? userEmail = null;

  Future googleLogIn(dynamic context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    final googleUser = await GoogleSignIn().signIn();

    userEmail = googleUser?.email;

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pop(context);
      Navigator.popAndPushNamed(context, '/main-screen');
    } on FirebaseAuthException catch (error) {
      await Alert(
              context: context,
              title: 'SOMETHING WENT WRONG',
              desc: error.message)
          .show();
    }
    notifyListeners();
  }

  Future signOut(dynamic context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.popAndPushNamed(context, '/');
    notifyListeners();
  }
}
