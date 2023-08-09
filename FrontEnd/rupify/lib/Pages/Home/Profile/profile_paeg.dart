import 'package:rupify/Src/requirements.dart';

class ProfilePage extends StatefulWidget {
  final UserModelPrimary user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: const Color(0xFF172A48),
        appBar: AppBar(
          backgroundColor: const Color(0xFF172A48),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(0), // Adjusted padding here
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF172A48),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('assets/images/user.png'),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'hi',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const Text(
                          'hello',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
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
                        () {
                          // TODO: Add function for Personal Details
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      buildElevatedButton(
                        context,
                        'Profile Settings',
                        () {
                          // TODO: Add function for Profile Settings
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      buildElevatedButton(
                        context,
                        'Change Password',
                        () {
                          // TODO: Add function for Change Password
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
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
      ),
    );
  }

  Widget buildElevatedButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(217, 217, 217, 1),
          onPrimary: const Color(0xFF172A48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              width: 1,
              color: Color(0xFF172A48),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.03,
          ),
          elevation: 2,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 26),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF172A48),
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(1, 2),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: const Color(0xFF172A48),
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(1, 2),
                  blurRadius: 1,
                ),
              ],
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
