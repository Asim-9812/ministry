import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/utils/toaster.dart';

Future<void> saveAsImagePdf(GlobalKey boundaryKey, String baseFileName) async {
  try {
    // 1. Capture widget as image
    RenderRepaintBoundary boundary = boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // 2. Create PDF
    final pdf = pw.Document();
    final imageProvider = pw.MemoryImage(pngBytes);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a3,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.SizedBox(
                width: PdfPageFormat.a3.availableWidth,
                child: pw.Image(imageProvider, fit: pw.BoxFit.fitWidth),
              ),
            );
          }
      ),
    );

    // 3. Save to Downloads
    final downloadsDir = Directory('/storage/emulated/0/Download');
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    String fileName = "${baseFileName}_appointment_$timestamp.pdf";


    final file = File('${downloadsDir.path}/$fileName');
    await file.writeAsBytes(await pdf.save());

  } catch (e) {
    print('Error saving image PDF: $e');
  }
}


Future<void> saveAsImage(GlobalKey previewContainerKey, String fileName) async {
  try {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      Toaster.error('Storage permission denied');
      return;
    }

    RenderRepaintBoundary boundary = previewContainerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    final downloadsDir = Directory('/storage/emulated/0/Download');
    final file = File('${downloadsDir.path}/${fileName}_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(pngBytes);

    Toaster.success('Saved image to Gallery');
  } catch (e) {
    Toaster.error('Failed to save image: $e');
  }
}

