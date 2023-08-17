import 'package:rupify/Src/requirements.dart';

Widget flashLight(bool pressed, QRViewController? controller){
  return Positioned(
    bottom: 200.0,
    left: 120.0,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        color: Color(0xFF172A48).withOpacity(0.7),
      ),
      child: IconButton(
        iconSize: 30,
        icon: Icon(
          !pressed?Icons.flash_on:Icons.flash_off,
          color: Colors.white,
        ),
        onPressed: () {
            controller!.toggleFlash();
            pressed = !pressed;
        },
      ),
    ),
  );
}