import 'package:rupify/Src/requirements.dart';

Widget paymentList(context,List<dynamic> entries){
  return Column(
    children: [
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
          padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 5),
          child: GridView.builder(
            physics:  const NeverScrollableScrollPhysics(),
            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
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
    ],
  );
}