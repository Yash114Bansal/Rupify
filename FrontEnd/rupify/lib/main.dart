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
      '/dashboard':(context)=>dashboard(),
      // '/scan':(context)=>,//TODO create a scanner page and add here
      // '/qr':(context)=>,//TODO create a qr generator and then add here
    },
  ));
}