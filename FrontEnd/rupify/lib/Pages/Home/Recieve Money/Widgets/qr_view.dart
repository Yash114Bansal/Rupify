import 'package:rupify/Services/Functions/scan_page_functions.dart';
import 'package:rupify/Src/requirements.dart';

Widget buildQrView(BuildContext context,QRViewController? controller,UserModelPrimary user,Barcode? result,GlobalKey qrKey) {
  var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 200.0 : 280.0;

  return QRView(
    key: qrKey,
    onQRViewCreated:(controller) => ScanPageFunctions(controller: controller,user: user).onQRViewCreated(controller, context, result!),
    overlay: QrScannerOverlayShape(
      borderColor: Colors.white,
      borderRadius: 10,
      borderLength: 30,
      borderWidth: 10,
      cutOutSize: scanArea,
      overlayColor: Colors.black87,
      cutOutBottomOffset: 100,
    ),
    onPermissionSet: (ctrl, p) => ScanPageFunctions(controller: ctrl, user: user).onPermissionSet(context, ctrl, p),
  );
}