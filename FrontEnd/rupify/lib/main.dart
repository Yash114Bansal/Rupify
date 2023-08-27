import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rupify/Pages/Home/Home/home_screen.dart';
import 'package:rupify/Pages/Home/wrapper.dart';
import 'package:rupify/Pages/Login/login.dart';
import 'package:http/http.dart' as http;
import 'package:rupify/Services/Models/user_model.dart';
import 'package:rupify/Services/user_model.dart';
import 'Services/all_api.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

loginAuthentication(String userToken) async {
  print(userToken);
  var userDetails = await http.get(Uri.parse(getUserDetailsAPI), headers: {
    'Authorization': 'Bearer $userToken',
  });
  Map<dynamic, dynamic> user =
      jsonDecode(userDetails.body) as Map<dynamic, dynamic>;
  print(user);
  return user;
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String token = await storage.read(key: 'access_token') ?? "noToken";
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  UserModelPrimary_old temp = UserModelPrimary_old(
      aadharNumber: '',
      userName: '',
      userPic: '',
      phoneNumber: '',
      availableBalance: 0,
      noteData: {},
      history: {},
      userData: {});
  Map<dynamic,dynamic> myUser;
  late UserModelPrimary user;
  if(token != 'noToken'){
    myUser= await loginAuthentication(token);
   user = UserModelPrimary.fromMap(myUser);
  }
  print("My Token is $token !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  return runApp((token == 'noToken')
      ? MaterialApp(
          theme: ThemeData(
              fontFamily: 'Outfit',
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white))),
          debugShowCheckedModeBanner: false,
            home: const LoginPage(),
        )
      : MaterialApp(
          theme: ThemeData(
              fontFamily: 'Outfit',
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white))),
          debugShowCheckedModeBanner: false,
          home: Dashboard(user: temp, myUser: user, token: token,),
            ));
}
