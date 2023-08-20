import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rupify/Pages/Login/login.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  return runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Outfit',
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white
        )
      )
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/login':(context)=>LoginPage(),
    },
  ));
}