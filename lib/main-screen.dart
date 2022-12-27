import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart';
import 'log-in-provider.dart';
import 'classes.dart';

class MainScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  Stream<List<Car>> readCars() => FirebaseFirestore.instance
      .collection(user.email.toString())
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Car.fromJson(doc.data())).toList());

  Widget buildCar(Car car) => Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            GestureDetector(
              child: Text(
                car.name,
                style: TextStyle(fontSize: 26),
              ),
              onTap: () {},
            ),
            SizedBox(width: 30),
            GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {},
            ),
            SizedBox(width: 30),
            GestureDetector(
              child: Icon(Icons.edit),
              onTap: () {},
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoogleSignInProvider>(
        create: (_) => GoogleSignInProvider(),
        builder: (context, child) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue[700],
              onPressed: () {
                Navigator.pushNamed(context, '/add-event-screen');
              },
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
                      image: AssetImage("assets/images/bg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
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
                      StreamBuilder<List<Car>>(
                          stream: readCars(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final cars = snapshot.data!;

                              return ListView(
                                children: cars.map(buildCar).toList(),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(15),
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
                        padding: const EdgeInsets.all(15),
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
                        padding: const EdgeInsets.all(15),
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
