import 'package:flutter/material.dart';
import 'package:rupify/Pages/Home/Recieve%20Money/scan.dart';
import 'package:rupify/Pages/Home/Send%20Money/send.dart';
import 'package:rupify/Pages/Home/Transactions%20History/Transactions.dart';
import 'package:rupify/Pages/Home/Wallet/wallet.dart';
import 'package:rupify/Pages/Home/Contacts/contacts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rupify/Services/contact.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class Dashboard extends StatefulWidget {
  final String Aadhar_Number;
  final Map<String,dynamic> user_data;
  const Dashboard({super.key, required this.Aadhar_Number,required this.user_data});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Map<String,People> _people = {
    '111111111111': People(name: "Muskan", profilePic: "https://drive.google.com/uc?export=download&id=1no3PBWeBNKmt9uf3-u0s4-a0zWdmY1BY", mobileNumber: "9999999990", purposes: [0], transactions: []),
    '111111111112': People(name: "Paras Upadhayay", profilePic: "https://drive.google.com/uc?export=download&id=15DfPsiWNuTGXF28eKjTuhoqt0P5j1Axw", mobileNumber: "9999999991", purposes: [0], transactions: []),
    '111111111113': People(name: "Khushi", profilePic: "https://drive.google.com/uc?export=download&id=13OKt98UD5fVDIlYQofrzU_VsjwUTfdI1", mobileNumber: "9999999993", purposes: [0], transactions: []),
    '111111111114': People(name: "Pushkar", profilePic: "https://drive.google.com/uc?export=download&id=1yaZP6H5kpBAokDgxwu0wb3RqR4tYtIpJ", mobileNumber: "9999999994", purposes: [0, 10], transactions: []),
    '111111111115': People(name: "Shreya", profilePic: "https://drive.google.com/uc?export=download&id=1ct_WwQ4odGbJAsOANmVBQ4n_nhD5O27r", mobileNumber: "9999999995", purposes: [0], transactions: []),
    '111111111116': People(name: "Nitin", profilePic: "https://drive.google.com/uc?export=download&id=1KoHx8yl7PAyr-sAmzQUzJZqZZgVe88El", mobileNumber: "9999999996", purposes: [0, 15], transactions: []),
    '222222222222': People(name: "Ramu", profilePic: "https://drive.google.com/uc?export=download&id=1tKDo5N7AWYP73dNzTx5mvpy8BsWloD8T", mobileNumber: "9999999997", purposes: [0, 15], transactions: []),
    '989898989898': People(name: "Dhruval Gupta", profilePic: "https://drive.google.com/uc?export=download&id=1SQg3fn5j8Z6RSCe1BArZu07eQLrftgM-", mobileNumber: "9999999992", purposes: [0], transactions: []),
  };
  Map<String,String> dashBoardIcons = {
    'assets/Icons/Internet.png':'WIFI',
    'assets/Icons/Electricity.png':'Electricity',
    'assets/Icons/Fast_Tag.png':'Fast Tag',
    'assets/Icons/Metro.png':'Metro',
    'assets/Icons/Recharge.png':'Recharge',
    'assets/Icons/Income_Tax.png':'Income Tax',
    'assets/Icons/Gas.png':'Gas',
    'assets/Icons/More.png':'More',
  };
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

      final responsePendingNotes = await http.post(
        Uri.parse('$Pending_Note_api?aadhar=${widget.Aadhar_Number}'),
        headers: {"Content-Type": "application/json"},
      );
      List<String> list = responsePendingNotes.body
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
          Note_Data.removeWhere((data, index) {
          List<String> parts = data.split("::");
          return parts.length > 1 && parts[0] == note;
        });
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
    List<People> Contacts = _people.values.toList();
    List<MapEntry<String, String>> entries = dashBoardIcons.entries.toList();
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // TODO :Handle icon button 1 press
                  },
                  iconSize: 40,
                  icon: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.user_data["Profile Pic"]),
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
              height: MediaQuery.of(context).size.height * 0.113,
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
                        '₹ ${_balance.toInt()}',
                        style: const TextStyle(
                          fontSize: 35,
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
                          MaterialPageRoute(builder: (context) => QrView(Note_Data: Note_Data,Aadhar_Number: widget.Aadhar_Number,History: History,user_data: widget.user_data, people: _people,)),
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
              child: const Text(
                'Payment List',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: GridView.builder(
                  physics: ClampingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    String key = entries[index].key;
                    String value = entries[index].value;
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // Add your onTap logic here
                          },
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              key,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.002),
                        Text(
                          value,
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
                  physics: const ClampingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Person(person: Contacts[index])));
                          },
                          child: CircleAvatar(
                            radius: 27,
                            backgroundImage: NetworkImage(Contacts[index].profilePic),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.002),
                        Text(
                          Contacts[index].name,
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
            MaterialPageRoute(builder: (context) => QrView(Note_Data: Note_Data,Aadhar_Number: widget.Aadhar_Number,History: History,user_data: widget.user_data, people: _people,)),
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
                  MaterialPageRoute(builder: (context) => Placeholder()), //TODO check it out once
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