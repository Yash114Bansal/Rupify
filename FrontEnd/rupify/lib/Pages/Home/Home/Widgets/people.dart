import 'package:rupify/Src/requirements.dart';

Widget people(context){
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.height * 0.27),
        child:  Text(
          'People',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.width*0.049,
            color: Colors.black,
          ),
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      SizedBox(
        height: MediaQuery.of(context).size.height*0.2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Contacts1(data: contacts[index].userName)));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: FadeInImage(
                          height: 60,
                          width: 60,
                          fadeInDuration: Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeInExpo,
                          fadeOutCurve: Curves.easeOutExpo,
                          placeholder:
                          AssetImage('assets/Icons/PlaceHolder.jpg'),
                          image: NetworkImage(contacts[index].userPic),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Container(
                                child: Image.asset(
                                    "assets/Icons/PlaceHolder.jpg"));
                          },
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.002),
                  Text(
                    contacts[index].userName,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              );
            },
          ),
        ),
      )
    ],
  );
}

