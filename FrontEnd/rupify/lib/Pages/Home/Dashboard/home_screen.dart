import 'package:rupify/Src/requirements.dart';

class HomeScreen extends StatefulWidget {
  final UserModelPrimary user;
  const HomeScreen({super.key,required this.user});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
  List<UserModelSecondary> Contacts = [
    UserModelSecondary(userName: 'Muskan', userPic: 'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp', phoneNumber: '9999999990'),
    UserModelSecondary(userName: 'Paras', userPic: 'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp', phoneNumber: '9999999991'),
    UserModelSecondary(userName: 'Dhruval', userPic: 'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp', phoneNumber: '9999999992'),
    UserModelSecondary(userName: 'Khushi', userPic: 'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp', phoneNumber: '9999999993'),
    UserModelSecondary(userName: 'Pushkar', userPic: 'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp', phoneNumber: '9999999994'),
    UserModelSecondary(userName: 'Shreya', userPic: 'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp', phoneNumber: '9999999995'),
    UserModelSecondary(userName: 'Nitin', userPic: 'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp', phoneNumber: '9999999996'),
    UserModelSecondary(userName: 'Ramu', userPic: 'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp', phoneNumber: '9999999997'),
  ];
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
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  print(widget.user.userData);
                },
                iconSize: 40,
                icon: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                  NetworkImage('https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp')
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.65),
              IconButton(
                onPressed: () {
                  // TODO: Handle icon button 2 press
                  print(widget.user.noteData);
                },
                iconSize: 40,
                icon: Image.asset(
                  'assets/Icons/notification.png',
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.113,
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Available Balance',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹ ${widget.user.availableBalance}',
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.05),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SendScreen(user: widget.user)),
                        );
                        setState(() {
                          Functions().updateEverything(widget.user);
                        });
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/Icons/send.png',
                            width: 48,
                            height: 48,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Send',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QrView(user: widget.user)),
                      );
                      setState(()  {
                         Functions().updateEverything(widget.user);
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/Icons/receive.png',
                          width: 48,
                          height: 48,
                        ),
                        const SizedBox(height: 5),
                        const Text(
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
                      setState(()  {
                         Functions().fetchData(context, widget.user);
                      });
                      setState(() {
                        Functions().updateEverything(widget.user);
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/Icons/fetch.png',
                          width: 48,
                          height: 48,
                        ),
                        const SizedBox(height: 5),
                        const Text(
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.height * 0.20),
            child: const Text(
              'Payment List',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  String key = entries[index].key;
                  String value = entries[index].value;
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Add your onTap logic here
                        },
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            key,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.002),
                      Text(
                        value,
                        style: const TextStyle(
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.height * 0.27),
            child: const Text(
              'People',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Contacts1(data: Contacts[index].userName)));
                        },
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: FadeInImage(
                              height: 60,
                              width: 60,
                              fadeInDuration:  Duration(milliseconds: 500),
                              fadeInCurve: Curves.easeInExpo,
                              fadeOutCurve: Curves.easeOutExpo,
                              placeholder: AssetImage('assets/Icons/PlaceHolder.jpg'),
                              image: NetworkImage(Contacts[index].userPic
                              ),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Container(child: Image.asset("assets/Icons/PlaceHolder.jpg"));
                              },
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.002),
                      Text(
                        Contacts[index].userName,
                        style: const TextStyle(
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
    );
  }
}
