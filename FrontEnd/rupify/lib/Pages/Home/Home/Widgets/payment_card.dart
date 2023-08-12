import 'package:rupify/Src/requirements.dart';

Widget paymentCard(context,UserModelPrimary user){
  return Padding(
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
                      builder: (context) => SendScreen(user: user)),
                );
                  Functions().updateEverything(user);
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
                    builder: (context) => QrView(user: user)),
              );
                Functions().updateEverything(user);
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
                Functions().fetchData(context, user);
                Functions().updateEverything(user);
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
  );
}
