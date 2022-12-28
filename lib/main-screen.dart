import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'log-in-provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late List<dynamic> cars = [];
  late dynamic car;

  Future getCars() async {
    await FirebaseFirestore.instance
        .collection(user.email.toString())
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              cars.add(document.reference.id);
            },
          ),
        );
  }

  Future getCar() async {
    List<dynamic> temp = [];

    await FirebaseFirestore.instance
        .collection(user.email.toString())
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              temp.add(document.reference.id);
            },
          ),
        );
    car = temp[0];
  }

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
          appBar: AppBar(
            backgroundColor: Colors.blue[700],
            title: FutureBuilder(
              future: getCar(),
              builder: (context, snapshot) {
                return Text(car);
              },
            ),
          ),
          drawer: Drawer(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.dstATop,
                  ),
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
                  Expanded(
                    child: FutureBuilder(
                        future: getCars(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                            itemCount: cars.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      cars[index],
                                      style: TextStyle(fontSize: 26),
                                    ),
                                    SizedBox(width: 30),
                                    Row(
                                      children: <Widget>[
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
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                  ),
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
          body: Container(),
        );
      },
    );
  }
}
