import 'package:rupify/Src/requirements.dart';

class HomeScreen extends StatefulWidget {
  final UserModelPrimary user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: const Color(0xFF172A48),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SizedBox(height: height*0.018),
            Positioned(
                top: height*0.015,
                left: 0,
                right: 0,
                child : Column(
                  children: [
                    appBar(context),
                    availableBalance(context, widget.user)
                  ],
                )
            ),

            paymentAndPeople(context, widget.user),
          ],
        ),
      ),
    );
  }
}
