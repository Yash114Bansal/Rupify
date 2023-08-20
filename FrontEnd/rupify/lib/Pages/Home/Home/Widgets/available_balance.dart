import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rupify/Services/user_model.dart';

Widget availableBalance(context,UserModelPrimary user){
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.17,
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Available Balance',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '₹ ${user.availableBalance}',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    ),
  );
}