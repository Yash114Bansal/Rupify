import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rupify/Pages/Login/login.dart';
import 'package:rupify/Src/requirements.dart';

class ProfilePage extends StatefulWidget {
  final UserModelPrimary_old user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF172A48),
      appBar: AppBar(
        backgroundColor: const Color(0xFF172A48),
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(height: height*0.005),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF172A48),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                   ClipRRect(
                     borderRadius: BorderRadius.circular(height*0.075),
                     child: FadeInImage(
                         height: height*0.15,
                         width: height*0.15,
                         fadeInDuration:  Duration(milliseconds: 500),
                         fadeInCurve: Curves.easeInExpo,
                         fadeOutCurve: Curves.easeOutExpo,
                         placeholder: AssetImage('assets/Icons/PlaceHolder.jpg'),
                         image: NetworkImage('https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp'),
                         imageErrorBuilder: (context, error, stackTrace) {
                           return Container(child: Image.asset("assets/Icons/PlaceHolder.jpg"));
                         },
                         fit: BoxFit.cover),
                   ),
                  SizedBox(height: height*0.015,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Paras Upadhayay',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: height*0.025,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        widget.user.aadharNumber,
                        style: TextStyle(
                          fontSize: height*0.020,
                          letterSpacing: width*0.01,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Expanded(
            child: Container(
              width: width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    buildElevatedButton(
                      context,
                      'Personal Details',
                      () async {
                        await storage.delete(key: 'access_token');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    buildElevatedButton(
                      context,
                      'Profile Settings',
                      () {
                        // TODO: Add function for Profile Settings
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    buildElevatedButton(
                      context,
                      'Change Password',
                      () {
                        // TODO: Add function for Change Password
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    buildElevatedButton(
                      context,
                      'Settings',
                      () {
                        // TODO: Add function for Settings
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildElevatedButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.075,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF172A48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              width: 1,
              color: Color(0xFF172A48),
            ),
          ),
          elevation: 2,
        ),
        child: Row(

          children: [
            Padding(

              padding: const EdgeInsets.only(left: 15),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height*0.023,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF172A48),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(1, 2),
                      blurRadius: 0.1,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined,color: Color(0xFF172A48), size: 24,shadows: [Shadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 2),
              blurRadius: 0.1,
            ),],),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
