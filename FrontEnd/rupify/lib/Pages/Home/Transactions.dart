import 'package:flutter/material.dart';

class transactions extends StatelessWidget {
  const transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background/transactions.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
