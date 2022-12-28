import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController nameController = TextEditingController();
  DateTime date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime(today.year + 1, today.month, today.day));

    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
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
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 40),
                    FractionallySizedBox(
                      child: TextFormField(
                        controller: nameController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Event',
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                      ),
                      widthFactor: 0.8,
                    ),
                    SizedBox(height: 40),
                    Column(
                      children: <Widget>[
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blue[700]!),
                          ),
                          onPressed: () => _selectDate(context),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: FractionallySizedBox(
                              child: Center(
                                child: Text(
                                  'Date',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              widthFactor: 0.8,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('${date.toLocal()}'.split(' ')[0]),
                      ],
                    ),
                    SizedBox(height: 40),
                    FractionallySizedBox(
                      child: TextFormField(
                        controller: nameController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Description',
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      widthFactor: 0.8,
                    ),
                    SizedBox(height: 40),
                    FractionallySizedBox(
                      child: TextFormField(
                        controller: nameController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Price',
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      widthFactor: 0.8,
                    ),
                    SizedBox(height: 40),
                    Column(
                      children: <Widget>[
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blue[700]!),
                          ),
                          onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
