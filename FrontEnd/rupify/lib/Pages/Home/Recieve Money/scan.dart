import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class Qr extends StatelessWidget {
  final Map<String, int> Note_Data;
  final String Aadhar_Number;
  final Map<String,int> History;
  Qr({Key? key,required this.Note_Data,required this.Aadhar_Number, required this.History}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QrView(Note_Data: Note_Data,Aadhar_Number: Aadhar_Number,History: History),
            ));
          },
          child: const Text('qrView'),
        ),
      ),
    );
  }
}

class QrView extends StatefulWidget {
  final Map<String, int> Note_Data;
  final String Aadhar_Number;
  final Map<String, int> History;
  const QrView({Key? key,required this.Note_Data,required this.Aadhar_Number, required this.History}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {
  Barcode? result;
  bool pressed = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String Get_Val_api = "https://funny-bull-bathing-suit.cyclic.app/getval";
  String Transfer_api = "https://drab-jade-duckling-cape.cyclic.app/transfer";
  Uint8List bytes = Uint8List(0);

  @override

  Future<void> scanImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print("File not Picked yet");
    }
  }

  void _makePayment(String? data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    controller!.pauseCamera();
    if (data != null && data.isNotEmpty) {
      List<String> list = data.replaceAll('[', '').replaceAll(']', '').split(',').map((element) => element.trim()).toList();
      List<String> Note_Without_Purpose = [];
      for (dynamic note in list) {
        Note_Without_Purpose.add(note.split("::")[0]);
        //TODO Purpose Check
      }
      final response0 = await http.post(
        Uri.parse(Transfer_api),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"note_list": Note_Without_Purpose, "shopkeeper_aadhar": widget.Aadhar_Number}),
      );
      List<dynamic> New_Note_List = json.decode(response0.body)["notes"];
      if (response0.statusCode == 406) {
        String Data = "";
        for (dynamic note in New_Note_List) {
          final response_get_value_of_new_note = await http.post(
            Uri.parse(Get_Val_api),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"note": note}),
          );
          Data += "\n";
          Data+=response_get_value_of_new_note.body;
        }
        Navigator.pop(context);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Payment Failed',
          desc: 'User Does Not Have Ownership Of Following Notes:$Data',
          btnOkOnPress: () {
            Navigator.pop(context);
          },
          btnOkColor: Colors.red,

        )..show();
        //TODO User have not ownership of following notes that are in new note list
      } else {

        int total_money = 0;
        for (dynamic note in New_Note_List) {
          final response_get_value_of_new_note = await http.post(
            Uri.parse(Get_Val_api),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"note": note}),
          );
          int amt = int.parse(response_get_value_of_new_note.body);
          note = note+"::0";
          widget.Note_Data[note] = amt;
          widget.History[note] = amt;
          total_money += amt;
        }
        Navigator.pop(context);
        print("showing Dialoge");
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Payment Successful',
          desc: 'Recieved ₹$total_money from NAME',
          btnOkOnPress: () {
            Navigator.pop(context);
          },

        )..show();
        print("Done Dialogue");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text('Scan & Receive'),
        backgroundColor: Color(0xFF172A48),
      ),
      body: Stack(
        children: [
          _buildQrView(context),
          Positioned(
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
                  setState(() {
                    pressed = !pressed;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 200.0,
            right: 120.0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF172A48).withOpacity(0.7),
              ),
              child: IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                ),
                onPressed: () async => await scanImageFromCamera(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 200.0 : 280.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
        overlayColor: Colors.black87,
        cutOutBottomOffset: 100,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      _makePayment(result!.code);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
