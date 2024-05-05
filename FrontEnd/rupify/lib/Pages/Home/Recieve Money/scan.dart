import 'package:rupify/Pages/Home/Recieve%20Money/Widgets/scanner_error_widget.dart';
import 'package:rupify/Services/Functions/scan_page_functions.dart';
import 'package:rupify/Src/requirements.dart';

class QrView extends StatefulWidget {
  final UserModelPrimary user;
  const QrView({Key? key,required this.user}) : super(key: key);

  @override
  _QrViewState createState() =>
      _QrViewState();
}

class _QrViewState
    extends State<QrView>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcode;

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: false,
  );

  bool isStarted = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan & Receive'),
        backgroundColor: const Color(0xFF172A48),
      ),
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
                fit: BoxFit.cover,
                onDetect: (barcode) {
                  setState(() {
                    controller.stop();
                    ScanPageFunctions(controller: controller,user: widget.user).makePayment(context, barcode.barcodes.first.rawValue);
                  });
                },
              ),
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.srcOut
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          backgroundBlendMode: BlendMode.dstOut
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 80),
                        height: MediaQuery.of(context).size.height*0.35,
                        width: MediaQuery.of(context).size.height*0.35,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height*0.5,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: controller.hasTorchState,
                      builder: (context, state, child) {
                        if (state != true) {
                          return const SizedBox.shrink();
                        }
                        return IconButton(
                          color: Colors.white,
                          icon: ValueListenableBuilder(
                            valueListenable: controller.torchState,
                            builder: (context, state, child) {
                              switch (state) {
                                case TorchState.off:
                                  return const Icon(
                                    Icons.flash_off,
                                    color: Colors.grey,
                                  );
                                case TorchState.on:
                                  return const Icon(
                                    Icons.flash_on,
                                    color: Colors.yellow,
                                  );
                              }
                            },
                          ),
                          iconSize: 25.0,
                          onPressed: () => controller.toggleTorch(),
                        );
                      },
                    ),
                    IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.image),
                      iconSize: 25.0,
                      onPressed: () => ScanPageFunctions(controller: controller, user: widget.user).scanImageFromGallery(context),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
