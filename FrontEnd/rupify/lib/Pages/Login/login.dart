import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:rupify/Pages/Login/requests_and_verification.dart';
import 'package:rupify/Services/Models/user_model.dart';
import 'package:rupify/Services/user_model.dart';
import '../Home/wrapper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _aadharTextController = TextEditingController();
  final TextEditingController _oppTextController = TextEditingController();

  bool otpSent = true;

  String? validateAadhar(String? value) {
    if (value!.isEmpty) {
      return 'Please enter Aadhar Number';
    }
    if (value.length != 12) {
      return 'Aadhar Number should be 12 digits long';
    }
    return null;
  }
  UserModelPrimary_old temp = UserModelPrimary_old(aadharNumber: 'aadharNumber', userName: 'userName', userPic: 'userPic', phoneNumber: 'phoneNumber', availableBalance: 0, noteData: {}, history: {}, userData: {});
  void goToMainPage(UserModelPrimary user,String token){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Dashboard(user: temp, myUser: user, token: token,)));
  }

  validate()async{
    Map<dynamic,dynamic> status = await UserAuthentication(aadharNumber: _aadharTextController.text).verifyOTP(_oppTextController.text);
    Map<dynamic,dynamic> userDetails =await UserAuthentication(aadharNumber: _aadharTextController.text).loginAuthentication(status['access_token']);
    await UserAuthentication(aadharNumber: _aadharTextController.text).saveToken(status['access_token']);
    UserModelPrimary user = UserModelPrimary.fromMap(userDetails);
    UserAuthentication(aadharNumber: _aadharTextController.text).saveToken(status['access_token']);
    goToMainPage(user,status['access_token']);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          color: const Color(0xFF172A48),
          child: Center(
            child: Container(
              color: const Color(0xFF172A48),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/Icons/logo.png'),
                          radius: 20,
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Rupify',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Effortless Payments, Peace of Mind",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 80),
                    Container(
                      width: 295,
                      height: 51,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: TextFormField(
                        onTap: () {

                        },
                        controller: _aadharTextController,
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Aadhar Number',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 26,
                          ),
                          counter: const SizedBox.shrink(),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                        validator: validateAadhar,
                      ),
                    ),

                    const SizedBox(height: 40),
                    Container(
                      width: 295,
                      height: 51,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _oppTextController,
                        maxLength: 6,
                        decoration: InputDecoration(
                          hintText: 'Enter OTP',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 26,
                          ),
                          counter: const SizedBox.shrink(),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 60,),
                    SizedBox(
                      width: 250,
                      height: 51,
                      child: ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                            if (_aadharTextController.text.length == 12) {
                                await UserAuthentication(aadharNumber: _aadharTextController.text).sendOTP();
                            } else {
                              Vibrate.feedback(FeedbackType.error);
                              setState(() {
                                _aadharTextController.clear();
                              });
                            }
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(63),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 250,
                      height: 51,
                      child: ElevatedButton(
                        onPressed: () {
                          validate();
                        },
                        child: Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(63),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
