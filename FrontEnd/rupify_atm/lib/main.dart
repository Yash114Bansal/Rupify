import 'package:flutter/material.dart';
import 'dart:math';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController Aadhar_Number = TextEditingController();
  final TextEditingController Note_Purpose = TextEditingController();
  int Note_Amount = 10;
  String noteNumber = '';
  bool isLoading = false;
  String govt_api = "https://funny-bull-bathing-suit.cyclic.app/putval";
  String rupify_api = "https://drab-jade-duckling-cape.cyclic.app/deposite";
  String generateRandomString(int length) {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final buffer = StringBuffer();



    for (int i = 0; i < length; i++) {
      buffer.write(chars[random.nextInt(chars.length)]);
    }

    return buffer.toString();
  }

  void refreshNoteNumber() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 500 ), () {
      setState(() {
        noteNumber = generateRandomString(16);
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    noteNumber = generateRandomString(16);
  }
  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Notes Deposited successfully.'),
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
  void _deposite_Money() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      // print(Aadhar_Number.text);
      // print(Note_Purpose.text);
      // print(noteNumber);
      // print(Note_Amount);
      final response1 = await http.post(
        Uri.parse(govt_api),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"number": noteNumber,"val":Note_Amount}),
      );
      final response2 = await http.post(
        Uri.parse(rupify_api),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"aadhar": Aadhar_Number.text,"note":noteNumber,"purpose":int.parse(Note_Purpose.text)}),
      );
      print(response2.body);
      print(response2.body);

      Navigator.pop(context);
      await _showSuccessDialog();
      refreshNoteNumber();
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
      body: GestureDetector(
        onVerticalDragEnd: (_) => refreshNoteNumber(),
        child: Container(
          color: const Color(0xFF172A48),
          child: Center(
            child: Container(
              color: const Color(0xFF172A48),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/logo.png'),
                          radius: 20,
                        ),
                        SizedBox(width: 16),
                        Text(
                          'ATM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                    Container(
                      width: 295,
                      height: 51,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: TextField(
                        enabled: false,
                        maxLength: 12,
                        decoration: InputDecoration(
                          hintText: noteNumber,
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 26,
                          ),
                          counter: const SizedBox.shrink(), // Remove the character count widget
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: 295,
                      height: 51,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: TextField(
                        controller: Aadhar_Number,
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                        decoration: InputDecoration(
                          hintText: 'Aadhar Number',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 26,
                          ),
                          counter: const SizedBox.shrink(), // Remove the character count widget
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: 295,
                      height: 51,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          hintText: 'Note Amount',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 26,
                          ),
                        ),
                        items: [
                          DropdownMenuItem<int>(
                            value: 10,
                            child: Text('10'),
                          ),
                          DropdownMenuItem<int>(
                            value: 20,
                            child: Text('20'),
                          ),
                          DropdownMenuItem<int>(
                            value: 50,
                            child: Text('50'),
                          ),
                          DropdownMenuItem<int>(
                            value: 100,
                            child: Text('100'),
                          ),
                          DropdownMenuItem<int>(
                            value: 200,
                            child: Text('200'),

                          ),
                          DropdownMenuItem<int>(
                            value: 500,
                            child: Text('500'),
                          ),
                          DropdownMenuItem<int>(
                            value: 1000,
                            child: Text('1000'),
                          ),
                          DropdownMenuItem<int>(
                            value: 2000,
                            child: Text('2000'),
                          ),
                          // Add more DropdownMenuItems as needed
                        ],
                        onChanged: (value) {
                          setState(() {
                            Note_Amount = value!; // Update the selected value
                          });
                        },
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),

                    const SizedBox(height: 40),
                    Container(
                      width: 295,
                      height: 51,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: TextField(
                        controller: Note_Purpose,
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                        decoration: InputDecoration(
                          hintText: 'Note Purpose',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 26,
                          ),
                          counter: const SizedBox.shrink(), // Remove the character count widget
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 60),
                    isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                      width: 250,
                      height: 51,
                      child: ElevatedButton(
                        onPressed: () {
                            _deposite_Money();
                        },
                        child: const Text(
                          'DEPOSIT',
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(63),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
