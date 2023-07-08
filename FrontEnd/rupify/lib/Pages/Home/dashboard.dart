import 'package:flutter/material.dart';
import 'package:rupify/Pages/Home/Send%20Money/send.dart';
import 'package:rupify/Pages/Home/Wallet/wallet.dart';

class dashboard extends StatelessWidget {
  dashboard({Key? key}) : super(key: key);
  Map<String, int> Note_Data = {
    '123123123':2000,
    '123123321':10,
    '312321123':500,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background/dashboard.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle icon button 1 press
                    },
                    icon: Image.asset(
                      'assets/Icons/profile.png',
                      width: 75,
                      height: 75,
                    ),
                  ),
                  SizedBox(width: 175),
                  IconButton(
                    onPressed: () {
                      // Handle icon button 2 press
                    },
                    icon: Image.asset(
                      'assets/Icons/notification.png',
                      width: 75,
                      height: 75,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.23,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.115,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SendScreen(Note_Data: Note_Data)),
                            );
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/Icons/send.png',
                                width: 48,
                                height: 48,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Send',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Handle button press
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/Icons/receive.png',
                                width: 48,
                                height: 48,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Receive',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Handle button press
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/Icons/fetch.png',
                                width: 48,
                                height: 48,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Fetch',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: const Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Available Balance',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹ 2,500',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.379,
              left: MediaQuery.of(context).size.width * 0.13,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Text(
                'People',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black
                ),
              ),

            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Person ${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF172A48),
        onPressed: () {
          // Handle FAB press
        },
        child: Icon(Icons.qr_code_scanner_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Color(0xFF172A48),
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                // Handle icon button 1 press
              },
              icon: Image.asset(
                'assets/Icons/home.png',
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                // Handle icon button 2 press
              },
              icon: Image.asset(
                'assets/Icons/transaction.png',
                width: 24,
                height: 24,
              ),
            ),
            SizedBox(width: 48),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletScreen(Note_Data: Note_Data)),
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
                // Handle icon button 4 press
              },
              icon: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
