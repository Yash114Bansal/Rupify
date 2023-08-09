import 'package:rupify/Src/requirements.dart';


class Wrapper extends StatefulWidget {
  final UserModelPrimary user;
  Wrapper({super.key,required this.user});
  @override
  State<Wrapper> createState() => _WrapperState();
}


class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;
  List<Widget> dashboardPages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dashboardPages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: const Color(0xFF172A48),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              icon: Image.asset(
                'assets/Icons/home.png',
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              icon: Image.asset(
                'assets/Icons/transaction.png',
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 48),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              icon: Image.asset(
                'assets/Icons/news.png',
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 4;
                });
              },
              icon: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
