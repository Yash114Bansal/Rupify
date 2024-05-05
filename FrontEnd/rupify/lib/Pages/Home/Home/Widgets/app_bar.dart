import 'package:flutter/material.dart';

Widget appBar(context){

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
        onPressed: () {},
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
        },
        iconSize: 40,
        icon: Image.asset(
          'assets/Icons/notification.png',
        ),
      ),
    ],
  );

}