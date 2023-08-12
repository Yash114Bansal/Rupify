
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
    List<MapEntry<String, String>> entries = dashBoardIcons.entries.toList();

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Background/dashboard.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        appBar(context),
        availableBalance(context, widget.user),
        paymentCard(context, widget.user),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        paymentList(context, entries),
        people(context),
      ]),
    );
  }
}
