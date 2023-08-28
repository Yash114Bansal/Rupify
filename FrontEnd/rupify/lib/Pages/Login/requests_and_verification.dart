import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:rupify/Services/all_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserAuthentication {
  String aadharNumber;
  UserAuthentication({required this.aadharNumber});

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> sendOTP() async {
    print("ready to send otp mate!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

    try{
      await http.post(Uri.parse(getOtpAPI), body: {'aadhar_number':aadharNumber}).whenComplete(() => (){
        log('OTP Sent Successfully');
        return true;
      });
    }catch(e){
      log(e.toString());
      return false;
    }
    return false;
  }

  verifyOTP(String otp) async {

    http.Response? verifiedUserToken;

       verifiedUserToken = await http.post(Uri.parse(verifyOTPAPI), body: {'aadhar_number':aadharNumber,'otp':otp});
        log((verifiedUserToken.body));
        if(verifiedUserToken.statusCode == 200){
          return jsonDecode(verifiedUserToken.body) as Map<String,dynamic>;
        }

  }

  loginAuthentication(String userToken) async {
    print(userToken);
    var userDetails = await http.get(Uri.parse(getUserDetailsAPI),headers: {
      'Authorization': 'Bearer $userToken',
    });
    Map<dynamic,dynamic> user = jsonDecode(userDetails.body)as Map<dynamic,dynamic>;
    return user;
  }

  Future<void> saveToken(String token) async {
      await storage.write(key: 'access_token', value: token);
  }

  Future<String> getToken()async{
    return await storage.read(key: 'access_token') ?? "noToken";
  }

}
