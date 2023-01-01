import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'log-in-provider.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  dynamic car = "";

  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content:
        Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      TextButton(
        child: Text("Cancel"),
        onPressed: () {},
      ),
      TextButton(
        child: Text("Continue"),
        onPressed: () {},
      ),
    ],
  );

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
  void initState() {
    super.initState();
    getCar();
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
              Navigator.pushNamed(context, '/add-event-screen',
                  arguments: {'car': car});
            },
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          appBar: AppBar(
            backgroundColor: Colors.blue[700],
            title: Text(car),
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(user.email.toString())
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Text(
                                      data['name'],
                                      style: TextStyle(fontSize: 26),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        car = data['name'];
                                      });
                                    },
                                  ),
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Icon(Icons.edit),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        },
                                      ),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        child: Icon(Icons.delete),
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection(user.email.toString())
                                              .doc(data['name'])
                                              .delete();
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
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
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('${user.email.toString()}-$car')
                .orderBy('date', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: data['price'] == ''
                              ? Text('FREE')
                              : Text('${data['price']} €'),
                          title: Text(data['name']),
                          subtitle: Text(
                              '${data['desc']}\n${DateFormat('yyyy-MM-dd').format(DateTime.parse(data['date'].toDate().toString()))}'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/edit-event-screen',
                                    arguments: {
                                      'address': data['address'],
                                      'name': data['name'],
                                      'date': data['date'],
                                      'desc': data['desc'],
                                      'price': data['price'],
                                      'car': car
                                    });
                              },
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: Icon(Icons.delete),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('${user.email.toString()}-$car')
                                    .doc(document['address'])
                                    .delete();
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        );
      },
    );
  }
}
