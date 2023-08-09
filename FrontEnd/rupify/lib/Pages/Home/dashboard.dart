import 'package:rupify/Src/requirements.dart';

class Dashboard extends StatefulWidget {

  final UserModelPrimary user;
  const Dashboard(
      {super.key, required this.user});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map<String, String> dashBoardIcons = {
    'assets/Icons/Internet.png': 'WIFI',
    'assets/Icons/Electricity.png': 'Electricity',
    'assets/Icons/Fast_Tag.png': 'Fast Tag',
    'assets/Icons/Metro.png': 'Metro',
    'assets/Icons/Recharge.png': 'Recharge',
    'assets/Icons/Income_Tax.png': 'Income Tax',
    'assets/Icons/Gas.png': 'Gas',
    'assets/Icons/More.png': 'More',
  };
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(user: widget.user),
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
                // TODO Handle icon button 1 press
              },
              icon: Image.asset(
                'assets/Icons/home.png',
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => transactions()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WalletScreen(user: widget.user)),
                );
              },
              icon: Image.asset(
                'assets/Icons/news.png',
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                // TODO Handle icon button 4 press
              },
              icon: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

}
