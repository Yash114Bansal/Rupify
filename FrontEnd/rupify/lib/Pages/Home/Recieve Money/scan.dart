import 'package:rupify/Pages/Home/Recieve%20Money/Widgets/flash_light_widget.dart';
import 'package:rupify/Pages/Home/Recieve%20Money/Widgets/import_image.dart';
import 'package:rupify/Pages/Home/Recieve%20Money/Widgets/qr_view.dart';
import 'package:rupify/Src/requirements.dart';


class QrView extends StatefulWidget {
  final UserModelPrimary user;
  const QrView({Key? key,required this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {
  Barcode? result;
  bool pressed = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan & Receive'),
        backgroundColor: const Color(0xFF172A48),
      ),
      body: Stack(
        children: [
          buildQrView(context, controller, widget.user, result, qrKey),
          flashLight(pressed, controller),
          importImage(pressed, controller, widget.user),
        ],
      ),
    );
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
