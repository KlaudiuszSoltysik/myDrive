import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final TextEditingController nameController = TextEditingController();
  DateTime oilDate = DateTime.now();
  DateTime ocDate = DateTime.now();

  Future<void> _selectOilDate(BuildContext context) async {
    DateTime today = DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: oilDate,
        firstDate: today,
        lastDate: DateTime(today.year + 1, today.month, today.day));
    if (picked != null && picked != oilDate) {
      setState(() {
        oilDate = picked;
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

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Center(
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
                    labelStyle: TextStyle(fontSize: 20)),
              ),
              widthFactor: 0.8,
            ),
            Column(
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue[700]!)),
                  onPressed: () => _selectOilDate(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: FractionallySizedBox(
                      child: Center(
                          child: Text(
                        'Select next oil change date',
                        style: TextStyle(fontSize: 20),
                      )),
                      widthFactor: 0.8,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('${oilDate.toLocal()}'.split(' ')[0]),
              ],
            ),
            Column(
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue[700]!)),
                  onPressed: () => _selectOcDate(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: FractionallySizedBox(
                      child: Center(
                          child: Text(
                        'Select OC renew date',
                        style: TextStyle(fontSize: 20),
                      )),
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
                      MaterialStateProperty.all<Color>(Colors.blue[700]!)),
              onPressed: () {
                if (nameController.text != null) {}
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: FractionallySizedBox(
                  child: Center(
                      child: Text(
                    'Save',
                    style: TextStyle(fontSize: 20),
                  )),
                  widthFactor: 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
