import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
class SendScreen extends StatefulWidget {
  final Map<String, int> Note_Data;
  final String Aadhar_Number;
  final Map<String, int> History;
  SendScreen({required this.Note_Data,required this.Aadhar_Number,required this.History});
  @override
  _SendScreenState createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  double _balance = 0;
  double _amount = 0;
  String qrData = '';
  late Timer _timer;
  String Pending_Note_api = "https://worried-slug-garment.cyclic.app/get_pending_note";
  String Get_Val_api = "https://funny-bull-bathing-suit.cyclic.app/getval";
  @override
  void initState() {
    super.initState();
    for (var value in widget.Note_Data.values) {
      _balance += value;
    }
  }
  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to stop it
    super.dispose();
  }
  void _startTimer() {
    const duration = Duration(seconds: 5);
    _timer = Timer.periodic(duration, (_) async {
      // TODO: Send request to the API here
      print('Sending request to the API...');
      final response_pending_notes = await http.post(
        Uri.parse('$Pending_Note_api?aadhar=${widget.Aadhar_Number}'),
        headers: {"Content-Type": "application/json"},
      );
      List<String> list = response_pending_notes.body
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('"', '')
          .split(',')
          .map((element) => element.trim())
          .where((element) => element.isNotEmpty)
          .toList();
      print("-------------------");
      print(list);
      if(list.length>0){
        for(dynamic note in list){
          final response2 = await http.post(
            Uri.parse(Get_Val_api),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"note": note}),
          );
          int responseData = int.parse(response2.body);
          widget.History[note] = -1*responseData;
          widget.Note_Data.remove(note+"::0");
        }
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Payment Successful',
          desc: 'Sent Money',
          btnOkOnPress: () {
            Navigator.pop(context);
          },

        )..show();
      }
    });
  }
  List<String>? getCurrencyNotes(Map<String, int> currencyDict, double p) {
    List<String> notes = currencyDict.keys.toList();
    notes.sort((a, b) => currencyDict[b]!.compareTo(currencyDict[a]!));
    List<String> result = [];
    for (String note in notes) {
      if (p >= currencyDict[note]!) {
        result.add(note);
        p -= currencyDict[note]!;
      }
      if (p == 0) {
        break;
      }
    }
    if (p > 0) {
      return null;
    } else {
      return result;
    }
  }

  void _sendMoney() async{
    if (_amount > _balance) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Insufficient balance'),
            content: const Text('You do not have enough money to make this transfer.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }else if(_amount == 0){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text('Please Enter Some Amount'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    else {
      List<String>? working_notes = getCurrencyNotes(widget.Note_Data, _amount);
      if (working_notes == null) {

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Cannot make transfer'),
              content: const Text('The entered amount cannot be made using the available notes.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          qrData = '$working_notes';
        });
        bool result = await InternetConnectionChecker().hasConnection;
        if(result){
          _startTimer();
        }

      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button press
              _timer.cancel();
              Navigator.of(context).pop();

            },
          ),
          title: const Text(
            'Transfer',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Available balance',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '₹$_balance',
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter amount',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _amount = double.parse(value);
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendMoney();
              },
              child: const Text('Send'),
            ),
            const SizedBox(height: 20),
            qrData.isNotEmpty?SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: QrImageView(
                size: 300,
                data: qrData,
                version: QrVersions.auto,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Colors.indigoAccent,
                ),
              ),
            ):const Text(
              'Please enter valid amount',
            )
          ],
        ),
      ),
    );
  }
}
