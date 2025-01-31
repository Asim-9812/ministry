
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:ministry/src/core/utils/toaster.dart';

import '../../../../core/resources/color_manager.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;
  final String title;
  const PDFViewerPage({super.key, required this.file,required this.title});

  @override
  PDFViewerPageState createState() => PDFViewerPageState();
}

class PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final text = '${indexPage + 1} of $pages';

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.black,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(widget.title,style: TextStyle(fontSize: 20,color: MyColors.white),),
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context),
          icon: Icon(Icons.chevron_left,color: MyColors.white,),
        ),
        actions: pages >= 2
            ? [
          Center(child: Text(text, style: const TextStyle(color: Colors.white),)),
          IconButton(
            icon: Icon(Icons.chevron_left, size: 32, color: indexPage > 0 ? Colors.white : Colors.grey,),
            onPressed: indexPage > 0 ? () {
              final page = indexPage - 1;
              controller.setPage(page);
            } : null,
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, size: 32, color: indexPage < pages - 1 ? Colors.white : Colors.grey,),
            onPressed: indexPage < pages - 1 ? () {
              final page = indexPage + 1;
              controller.setPage(page);
            } : null,
          ),
        ]
            : null,

      ),
      body: PDFView(
        filePath: widget.file.path,
        autoSpacing: false,
        swipeHorizontal: true,
        fitEachPage: true,

        // pageSnap: false,
        // pageFling: true,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
        onError: (error){
          Toaster.error(error);
        },
      ),
    );
  }
}