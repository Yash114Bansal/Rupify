import 'package:flutter/material.dart';

class Contacts1 extends StatelessWidget {
   Contacts1({Key? key,required this.data}) : super(key: key);
   final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          data,
        ),
      ),
    );
  }
}
