import 'package:flutter/material.dart';

class Contacts1 extends StatelessWidget {
   Contacts1({Key? key,required this.data}) : super(key: key);
   final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF172A48),
        centerTitle: true,
        title: Text(
          data,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background/history.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
