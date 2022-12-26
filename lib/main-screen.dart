import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart';

import 'log-in-provider.dart';

class MainScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoogleSignInProvider>(
        create: (_) => GoogleSignInProvider(),
        builder: (context, child) {
          return Scaffold(
            body: SliderDrawer(
              key: key,
              appBar: SliderAppBar(
                appBarColor: Colors.white,
                title: Text(
                  'vehicle 1',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              sliderOpenSize: 300,
              slider: SafeArea(
                child: Container(
                  color: Colors.blueGrey[300],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            user.displayName!,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(user.photoURL!),
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              child: Text(
                                'vehicle 1',
                                style: TextStyle(fontSize: 26),
                              ),
                              onTap: () {},
                            ),
                            SizedBox(width: 30),
                            GestureDetector(
                              child: Icon(Icons.delete),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              child: Text(
                                'vehicle 2',
                                style: TextStyle(fontSize: 26),
                              ),
                              onTap: () {},
                            ),
                            SizedBox(width: 30),
                            GestureDetector(
                              child: Icon(Icons.delete),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Text(
                            'Add new vehicle',
                            style: TextStyle(fontSize: 26),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/add-vehicle-screen');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Text(
                            'Sign out',
                            style: TextStyle(fontSize: 26),
                          ),
                          onTap: () {
                            Provider.of<GoogleSignInProvider>(context,
                                    listen: false)
                                .signOut(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Text(
                            'Delete account',
                            style: TextStyle(fontSize: 26),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: Container(),
            ),
          );
        });
  }
}
