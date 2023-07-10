import 'package:flutter/material.dart';

import '../Home/dashboard.dart';

class login extends StatelessWidget {
  login({Key? key}) : super(key: key);
  final TextEditingController _textFieldController = TextEditingController();

  void _navigateToDestinationPage(BuildContext context) {
    String data = _textFieldController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(Aadhar_Number: data),
      ),
    );
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
                      child: TextField(
                        controller: _textFieldController,
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                        decoration: InputDecoration(
                          hintText: 'Aadhar Number',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),

                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 26,
                          ),
                          counter: const SizedBox.shrink(), // Remove the character count widget
                        ),
                        style: const TextStyle(color: Colors.black,fontSize: 20),
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
                            vertical: 10,
                            horizontal: 26,
                          ),
                          counter: const SizedBox.shrink(), // Remove the character count widget
                        ),
                        style: const TextStyle(color: Colors.black,fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 60,),

                    SizedBox(
                      width: 250,
                      height: 51,
                      child: ElevatedButton(
                        onPressed: () {
                          _navigateToDestinationPage(context);
                        },
                        child: const Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, backgroundColor: Colors.white,
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
