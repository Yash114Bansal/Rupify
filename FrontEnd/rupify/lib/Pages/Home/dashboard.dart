import 'package:flutter/material.dart';
import 'package:rupify/Pages/Home/Recieve%20Money/scan.dart';
import 'package:rupify/Pages/Home/Send%20Money/send.dart';
import 'package:rupify/Pages/Home/Transactions.dart';
import 'package:rupify/Pages/Home/Wallet/wallet.dart';
import 'package:rupify/Pages/Home/Contacts/contacts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../Services/balance_statements.dart';

class Dashboard extends StatefulWidget {
  final String Aadhar_Number;
  Dashboard({required this.Aadhar_Number});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> Contacts = ["Paras","Pushkar","Yash","Manas","Kartik","Dhruval","Lakshya","Sankalp"];
  double _balance = 0;
  double _toShow = 0;
  Map<String, int> Note_Data = {};
  // String Aadhar_Number = '1234-5678-1234-5678';
  String Rupify_api = "https://worried-slug-garment.cyclic.app/get_money";
  String Get_Val_api = "https://funny-bull-bathing-suit.cyclic.app/getval";
  @override
  void initState() {
    super.initState();

  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Notes fetched successfully.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _fetchData() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    print("chachhca");
    bool result = await InternetConnectionChecker().hasConnection;
    
    if (result) {
      print("chachhca");
      final response = await http.post(
        Uri.parse(Rupify_api),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"aadhar": '111111111112'}),
      );
      final responseData = jsonDecode(response.body);
      print(responseData);
      List<dynamic> notes = responseData['notes'];
      for (dynamic note in notes) {
        String real_note = note.split("::")[0];
        print(real_note);
        final response2 = await http.post(
          Uri.parse(Get_Val_api),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"note": real_note}),
        );
        int responseData = int.parse(response2.body);
        Note_Data[note] = responseData;
        for (var value in Note_Data.values) {
          _balance += value;
        }
      }
      print(Note_Data);
      Navigator.pop(context);
      await _showSuccessDialog();
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Not connected to the internet.'),
          duration: Duration(seconds: 4),
        ),
      );
      Navigator.pop(context);
      return;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background/dashboard.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO :Handle icon button 1 press
                    },
                    icon: Image.asset(
                      'assets/Icons/profile.png',
                      width: 75,
                      height: 75,
                    ),
                  ),
                  SizedBox(width: 175),
                  IconButton(
                    onPressed: () {
                      // TODO: Handle icon button 2 press
                    },
                    icon: Image.asset(
                      'assets/Icons/notification.png',
                      width: 75,
                      height: 75,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.23,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.115,
                child: SingleChildScrollView(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SendScreen(Note_Data: Note_Data)),
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/Icons/send.png',
                                  width: 48,
                                  height: 48,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Send',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Handle button press
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/Icons/receive.png',
                                  width: 48,
                                  height: 48,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Receive',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {

                              setState(() {
                                _fetchData();
                              });
                              setState(() {
                                _toShow = _balance;
                              });


                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/Icons/fetch.png',
                                  width: 48,
                                  height: 48,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Fetch',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child:  Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Text(
                            'Available Balance',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '$_toShow',
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.38,
              left: MediaQuery.of(context).size.width * 0.13,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Text(
                'Payment List',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.43,
                left: MediaQuery.of(context).size.width * 0.12,
                right: MediaQuery.of(context).size.width * 0.1,
                child:Row(
                  children: [
                    InkWell(
                      onTap: ()=>{},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                              'assets/Icons/internet.png',
                              width: 50,
                              height: 50
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Internet',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 28),
                    InkWell(
                      onTap: ()=>{},
                      child: Column(
                        children: [
                          Image.asset(
                              'assets/Icons/electricity.png',
                              width: 50,
                              height: 50
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Electricity',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 28),
                    InkWell(
                      onTap: ()=>{},
                      child: Column(
                        children: [
                          Image.asset(
                              'assets/Icons/merchant.png',
                              width: 50,
                              height: 50
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Merchant',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 28),
                    InkWell(
                      onTap: ()=>{},
                      child: Column(
                        children: [
                          Image.asset(
                              'assets/Icons/more.png',
                              width: 50,
                              height: 50
                          ),
                          SizedBox(height: 5),
                          Text(
                            'More',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.56,
              left: MediaQuery.of(context).size.width * 0.13,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Text(
                'People',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.57,
              left: MediaQuery.of(context).size.width * 0.07,
              right: MediaQuery.of(context).size.width * 0.1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Contacts1(data: Contacts[index])));
                          },
                          child: CircleAvatar(
                            radius: 27,
                            child: Text(
                              Contacts[index][0],
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: (index%2 == 0)?Colors.blue:Colors.blueAccent,

                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          Contacts[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF172A48),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QrView()),
          );
        },
        child: Icon(Icons.qr_code_scanner_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Color(0xFF172A48),
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                // Handle icon button 1 press
              },
              icon: Image.asset(
                'assets/Icons/home.png',
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => transactions()),
                );
              },
              icon: Image.asset(
                'assets/Icons/transaction.png',
                width: 24,
                height: 24,
              ),
            ),
            SizedBox(width: 48),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletScreen(Note_Data: Note_Data)),
                );
              },
              icon: Image.asset(
                'assets/Icons/news.png',
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                // Handle icon button 4 press
              },
              icon: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}