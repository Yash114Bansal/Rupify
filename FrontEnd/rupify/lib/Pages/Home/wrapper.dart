import 'package:rupify/Pages/Home/Profile/profile_paeg.dart';
import 'package:rupify/Src/requirements.dart';

class Dashboard extends StatefulWidget {

  final UserModelPrimary user;
  Dashboard(
      {super.key, required this.user});
  int selectedIndex = 0;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [HomeScreen(user: widget.user),Transactions(),WalletScreen(user: widget.user),ProfilePage(user: widget.user)];
    return Scaffold(
      extendBody: true,
      body: pages[widget.selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF172A48),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QrView(user: widget.user,)),
          );
          Functions().updateEverything(widget.user);
        },
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                  widget.selectedIndex = 0;
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
                  widget.selectedIndex = 1;
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
                  widget.selectedIndex = 2;
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
                  widget.selectedIndex = 3;
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
