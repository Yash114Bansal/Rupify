import 'package:flutter/material.dart';
import 'package:rupify/Pages/Home/Wallet/wallet.dart';
import 'package:rupify/Pages/Home/dashboard.dart';
import 'package:rupify/Pages/Login/login.dart';

void main(){
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/login':(context)=>login(),
      '/dashboard':(context)=>Dashboard(Aadhar_Number: '111111111112'),
    },
  ));
}