import 'package:flutter/material.dart';
import 'package:rupify/Pages/Login/login.dart';

void main(){
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/login':(context)=>login(),
    },
  ));
}