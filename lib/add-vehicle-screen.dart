import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final TextEditingController nameController = TextEditingController();
  DateTime reviewDate = DateTime.now();
  DateTime ocDate = DateTime.now();

  Future<void> _selectReviewDate(BuildContext context) async {
    DateTime today = DateTime.now();

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
    if (nameController.text != null) {
      final docVehicle = FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .doc(nameController.text);

      final json = {
        'name': nameController.text,
        'review': reviewDate,
        'oc': ocDate
      };

      await docVehicle.set(json);

      nameController.clear();
      reviewDate = DateTime.now();
      ocDate = DateTime.now();

      Navigator.pushNamedAndRemoveUntil(
          context, '/main-screen', (Route<dynamic> route) => false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FractionallySizedBox(
                child: TextFormField(
                  controller: nameController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                widthFactor: 0.8,
              ),
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
        ),
      ),
    );
  }
}
