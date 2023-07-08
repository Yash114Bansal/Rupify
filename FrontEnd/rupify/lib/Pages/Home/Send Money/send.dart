import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
class SendScreen extends StatefulWidget {
  final Map<String, int> Note_Data;
  SendScreen({required this.Note_Data});
  @override
  _SendScreenState createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  double _balance = 0;
  double _amount = 0;
  String qrData = '';

  @override
  void initState() {
    super.initState();
    // calculate the balance from Note_Data when the widget is first initialized
    for (var value in widget.Note_Data.values) {
      _balance += value;
    }
  }
  List<String>? getCurrencyNotes(Map<String, int?> currencyDict, double p) {
    List<String> notes = currencyDict.keys.toList();
    notes.sort((a, b) => (currencyDict[b] ?? 0) - (currencyDict[a] ?? 0));
    List<String> result = [];
    for (String note in notes) {
      while (p >= (currencyDict[note] ?? 0)) {
        result.add(note);
        p -= (currencyDict[note] ?? 0);
      }
    }
    if (p > 0) {
      return null;
    } else {
      return result;
    }
  }

  void _sendMoney() {
    if (_amount > _balance) {
      // show a pop-up if the amount entered is greater than the available balance
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
    } else {
      // perform the transfer
      List<String>? working_notes = getCurrencyNotes(widget.Note_Data, _amount);
      print(working_notes);
      if (working_notes == null) {
        // show a pop-up if the amount cannot be made using available notes
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
          qrData = '$_amount$working_notes';
        });
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
            qrData.isNotEmpty?QrImageView(
              size: 300,
              data: qrData,
              version: 1,
              // embeddedImage: AssetImage('assets/img/erupi.png'),
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: Colors.indigoAccent,
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
