import 'package:flutter/material.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/gap_manager.dart';
import 'widgets/scanner_overlay.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final controller = MobileScannerController();

  @override
  void initState() {
    super.initState();

    // Create scanning animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.stop();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    Uri? uri = Uri.tryParse(url);
    return uri != null && (uri.scheme == "http" || uri.scheme == "https");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MobileScanner(
          controller: controller,
          overlayBuilder: (context, constraints) {
            return Stack(
              children: [
                ClipPath(
                  clipper: ScannerOverlayClipper(),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: MyColors.white.withOpacity(0.5),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(

                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                icon: Icon(Icons.arrow_back,color: MyColors.white,),
                                onPressed: ()=>Navigator.pop(context)
                            ),
                            // regularIconButton(color: MyColors.white,icon: Icons.photo, onPressed: (){}),
                          ],
                        ),
                        Image.asset('assets/images/logo.png', width: 100, height: 100),
                        h10,
                        Text('Scan Your QR',style: wr1,),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: constraints.maxWidth * 0.6,
                    height: constraints.maxHeight * 0.3,
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Positioned(
                              top: _animation.value * (constraints.maxHeight * 0.3 - 5),
                              left: 0,
                              right: 0,
                              child: Container(
                                width: double.infinity,
                                height: 4,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.red.withOpacity(0.6), Colors.red.withOpacity(0.9)],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          onDetect: (barcodes) {
            if (barcodes.barcodes.isNotEmpty) {
              controller.pause();
              String scannedValue = barcodes.barcodes.first.rawValue.toString();

              if (_isValidUrl(scannedValue)) {
                openUrl(scannedValue);
              } else {
                showQrDetails(context, scannedValue);
              }


              print('Detected: $scannedValue');
            }
            print('Detected: ${barcodes.barcodes.first.rawValue}');
          },
        ),
      ),
    );
  }

  void showQrDetails(context,String values) async{

    await showModalBottomSheet(context: context, builder: (context){

      return Container(
        constraints: BoxConstraints(
            minHeight: 200
        ),
        width: double.infinity,
        decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12))
        ),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.close,))),
            Text('Result',style: bh2,),
            h20,
            Text(values,style: br1,),
          ],
        ),
      );

    });
    controller.start();

  }

  void openUrl(String code) async {
    String url = code;
    if (url.startsWith('http://')) {
      url = url.replaceFirst('http://', 'https://');
      launchUrlString(url,mode: LaunchMode.externalApplication);
    }else{
      launchUrlString(url,mode: LaunchMode.externalApplication);
    }

    controller.start();
    // final Uri uri = Uri(
    //     path: code,
    //     scheme: 'https'
    // );

  }


}




