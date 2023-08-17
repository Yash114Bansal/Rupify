import 'package:rupify/Src/requirements.dart';

import '../../../../Services/Functions/scan_page_functions.dart';

Widget importImage(bool pressed, QRViewController? controller,UserModelPrimary user){
  return Positioned(
    bottom: 200.0,
    right: 120.0,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF172A48).withOpacity(0.7),
      ),
      child: IconButton(
        iconSize: 30,
        icon: const Icon(
          Icons.image_outlined,
          color: Colors.white,
        ),
        onPressed: () async => await ScanPageFunctions(user: user,controller: controller!).scanImageFromCamera(),
      ),
    ),
  );
}