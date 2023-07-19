import 'package:flutter/material.dart';
import 'package:rupify/Pages/Home/Recieve%20Money/scan.dart';
import 'package:rupify/Pages/Home/Send%20Money/send.dart';
import 'package:rupify/Pages/Home/Transactions%20History/Transactions.dart';
import 'package:rupify/Pages/Home/Wallet/wallet.dart';
import 'package:rupify/Pages/Home/Contacts/contacts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class Dashboard extends StatefulWidget {
  final String Aadhar_Number;
  const Dashboard({super.key, required this.Aadhar_Number});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> Contacts = ["Paras","Pushkar","Yash","Manas","Kartik","Dhruval","Lakshya","Sankalp"];
  double _balance = 0;
  Map<String, int> Note_Data = {};
  Map<String, int> History = {};
  String Rupify_api = "https://drab-jade-duckling-cape.cyclic.app/get_money";
  String Get_Val_api = "https://funny-bull-bathing-suit.cyclic.app/getval";
  String Pending_Note_api = "https://drab-jade-duckling-cape.cyclic.app/get_pending_note";
  @override
  void initState() {
    super.initState();

  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Notes fetched successfully.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void updateEverything(){
    double sum = Note_Data.values.fold(0, (previousValue, element) => previousValue + element);
    setState(() {
      _balance = sum;
    });
    sum = Note_Data.values.fold(0, (previousValue, element) => previousValue + element);
    setState(() {
      _balance = sum;
    });
  }
  void _fetchData(String aadharNumber) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      final response = await http.post(
        Uri.parse(Rupify_api),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"aadhar": aadharNumber}),
      );
      final responseData = jsonDecode(response.body);
      List<dynamic> notes = responseData['notes'];
      for (dynamic note in notes) {
        String realNote = note.split("::")[0];
        final response2 = await http.post(
          Uri.parse(Get_Val_api),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"note": realNote}),
        );
        int responseData = int.parse(response2.body);
        Note_Data[note] = responseData;
        History[note] = responseData;
      }

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
      for(dynamic note in list){
          final response2 = await http.post(
            Uri.parse(Get_Val_api),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"note": note}),
          );
          int responseData = int.parse(response2.body);
          History[note] = -1*responseData;
          Note_Data.remove(note+"::0");
      }
      updateEverything();
      Navigator.pop(context);
      await _showSuccessDialog();
    }

    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.030),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // TODO :Handle icon button 1 press
                  },
                  iconSize: 40,
                  icon: Image.asset(
                    'assets/Icons/profile.png',
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.65),
                IconButton(
                  onPressed: () {
                    // TODO: Handle icon button 2 press
                  },
                  iconSize: 40,
                  icon: Image.asset(
                    'assets/Icons/notification.png',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.112,
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Available Balance',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_balance',
                        style: const TextStyle(
                          fontSize: 43,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.005),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.05),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async{
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SendScreen(Note_Data: Note_Data,Aadhar_Number: widget.Aadhar_Number,History: History,)),
                          );
                          updateEverything();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/Icons/send.png',
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Send',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async{
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QrView(Note_Data: Note_Data,Aadhar_Number: widget.Aadhar_Number,History: History,)),
                        );
                        updateEverything();
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/Icons/receive.png',
                            width: 48,
                            height: 48,
                          ),
                          const SizedBox(height: 5),
                          const Text(
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
                        _fetchData(widget.Aadhar_Number);
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/Icons/fetch.png',
                            width: 48,
                            height: 48,
                          ),
                          const SizedBox(height: 5),
                          const Text(
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
             Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.20),
              child: Text(
                'Payment List',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                InkWell(
                  onTap: () => {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/Icons/internet.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Internet',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.height * 0.035),
                InkWell(
                  onTap: () => {},
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/Icons/electricity.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Electricity',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.height * 0.035),
                InkWell(
                  onTap: () => {},
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/Icons/merchant.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Merchant',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.height * 0.035),
                InkWell(
                  onTap: () => {},
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/Icons/more.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'More',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.27),
              child: const Text(
                'People',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            backgroundColor: (index%2 == 0)?Colors.blue:Colors.blueAccent,
                            child: Text(
                              Contacts[index][0],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.002),
                        Text(
                          Contacts[index],
                          style: const TextStyle(
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
        backgroundColor: const Color(0xFF172A48),
        onPressed: () async{
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QrView(Note_Data: Note_Data,Aadhar_Number: widget.Aadhar_Number,History: History,)),
          );
          updateEverything();
        },
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: const Color(0xFF172A48),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                // TODO Handle icon button 1 press
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
            const SizedBox(width: 48),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletScreen(History: History, Amount: _balance, Note_Data: Note_Data, Aadhar_Number: widget.Aadhar_Number,)),
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
                // TODO Handle icon button 4 press
              },
              icon: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}