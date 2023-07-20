import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../Home/dashboard.dart';
import 'package:http/http.dart' as http;
class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController _textFieldController = TextEditingController();

  String title = "Continue";
  String getDetails = "https://funny-bull-bathing-suit.cyclic.app/get_detailes";

  void _navigateToDestinationPage(BuildContext context) async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    String data = _textFieldController.text;
    bool result = await InternetConnectionChecker().hasConnection;
    if(result){
      final response = await http.post(
        Uri.parse(getDetails),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"aadhar": data}),
      );
      if(response.statusCode == 404){
        print("Invalid Aadhar");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Aadhar'),
            duration: Duration(seconds: 4),
          ),
        );
        Navigator.pop(context);
        return;
      }
      final user_details = jsonDecode(response.body);
      print(user_details);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(Aadhar_Number: data,user_data: user_details,),
        ),
      );
      Navigator.pop(context);
    }else{
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

  String? validateAadhar(String? value) {
    if (value!.isEmpty) {
      return 'Please enter Aadhar Number';
    }
    if (value.length != 12) {
      return 'Aadhar Number should be 12 digits long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          color: const Color(0xFF172A48),
          child: Center(
            child: Container(
              color: const Color(0xFF172A48),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/Icons/logo.png'),
                          radius: 20,
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Rupify',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Effortless Payments, Peace of Mind",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 80),
                    Container(
                      width: 295,
                      height: 51,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: TextFormField(
                        onTap: () {
                          setState(() {
                            title = "Continue";
                          });
                        },
                        controller: _textFieldController,
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Aadhar Number',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 26,
                          ),
                          counter: const SizedBox.shrink(),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                        validator: validateAadhar,
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
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: InputDecoration(
                          hintText: 'Enter OTP',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 26,
                          ),
                          counter: const SizedBox.shrink(),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 60,),

                    SizedBox(
                      width: 250,
                      height: 51,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_textFieldController.text.length == 12) {

                            _navigateToDestinationPage(context);
                          } else {
                            Vibrate.feedback(FeedbackType.error);
                            setState(() {

                              _textFieldController.clear();
                            });
                          }
                        },
                        child: Text(
                          '$title',
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
