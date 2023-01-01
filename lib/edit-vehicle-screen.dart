import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class EditVehicleScreen extends StatefulWidget {
  @override
  _EditVehicleScreenState createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends State<EditVehicleScreen> {
  late DateTime reviewDate;
  late DateTime ocDate;
  late String name;
  bool firstTime = false;

  Future<void> _selectReviewDate(BuildContext context) async {
    DateTime today = DateTime.now();
    firstTime = true;

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: reviewDate,
        firstDate: today,
        lastDate: DateTime(today.year + 1, today.month, today.day));
    if (picked != null && picked != reviewDate) {
      setState(() {
        reviewDate = picked;
      });
    }
  }

  Future<void> _selectOcDate(BuildContext context) async {
    DateTime today = DateTime.now();
    firstTime = true;

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: ocDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(today.year + 1, today.month, today.day));

    if (picked != null && picked != ocDate) {
      setState(() {
        ocDate = picked;
      });
    }
  }

  Future saveVehicle() async {
    final docVehicle = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email.toString())
        .doc(name);

    final json = {'review': reviewDate, 'oc': ocDate};

    await docVehicle.update(json);

    reviewDate = DateTime.now();
    ocDate = DateTime.now();

    Navigator.pushNamedAndRemoveUntil(
        context, '/main-screen', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    if (firstTime == false) {
      ocDate = DateTime.parse(arguments['oc'].toDate().toString());
      reviewDate = DateTime.parse(arguments['review'].toDate().toString());
    }

    name = arguments['name'];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Expanded(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Edit vehicle',
                  style: TextStyle(fontSize: 40),
                ),
              ),
              SizedBox(height: 40),
              Column(
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue[700]!),
                    ),
                    onPressed: () => _selectReviewDate(context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: FractionallySizedBox(
                        child: Center(
                          child: Text(
                            'Select car review date',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        widthFactor: 0.8,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('${reviewDate.toLocal()}'.split(' ')[0]),
                ],
              ),
              SizedBox(height: 40),
              Column(
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue[700]!),
                    ),
                    onPressed: () => _selectOcDate(context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: FractionallySizedBox(
                        child: Center(
                          child: Text(
                            'Select OC renew date',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        widthFactor: 0.8,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('${ocDate.toLocal()}'.split(' ')[0]),
                ],
              ),
              SizedBox(height: 40),
              Column(
                children: <ElevatedButton>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue[700]!),
                    ),
                    onPressed: () {
                      saveVehicle();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: FractionallySizedBox(
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        widthFactor: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
