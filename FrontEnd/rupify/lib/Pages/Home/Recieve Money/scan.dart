import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class Qr extends StatelessWidget {
  final Map<String, int> Note_Data;
  final String Aadhar_Number;
  Qr({Key? key,required this.Note_Data,required this.Aadhar_Number}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QrView(Note_Data: Note_Data,Aadhar_Number: Aadhar_Number,),
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
  const QrView({Key? key,required this.Note_Data,required this.Aadhar_Number}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String Get_Val_api = "https://funny-bull-bathing-suit.cyclic.app/getval";
  String Transfer_api = "https://worried-slug-garment.cyclic.app/transfer";

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
  void _makePayment(String? data) async{
          controller?.pauseCamera();
          if(data != null && data.isNotEmpty){
            List<String> list = data
                .replaceAll('[', '')
                .replaceAll(']', '')
                .split(',')
                .map((element) => element.trim())
                .toList();
            List<String> Note_Without_Purpose =[];
            for (dynamic note in list){
              Note_Without_Purpose.add(note.split("::")[0]);
              //TODO Purpose Check
            }
            final response0 = await http.post(
                Uri.parse(Transfer_api),
                headers: {"Content-Type": "application/json"},
                body: json.encode({"note_list": Note_Without_Purpose,"shopkeeper_aadhar":widget.Aadhar_Number}),
            );
            List<dynamic> New_Note_List = json.decode(response0.body)["notes"];
            if(response0.statusCode == 406){
                  //TODO User have not ownership of following notes that are in new note list
            }else{
              for(dynamic note in New_Note_List){
                    final response_get_value_of_new_note = await http.post(
                      Uri.parse(Get_Val_api),
                      headers: {"Content-Type": "application/json"},
                      body: json.encode({"note": note}),
                    );
                    widget.Note_Data[note] =
                        int.parse(response_get_value_of_new_note.body);
                  }
              }
            }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Data:')

                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
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