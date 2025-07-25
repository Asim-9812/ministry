





import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart' as w2p;


class EnquiryReportHtml extends ConsumerWidget {
  final String html;
  const EnquiryReportHtml({required this.html, super.key});

  @override
  Widget build(BuildContext context, ref) {
    final wrappedHtml = makeDesktopHtml(html);

    // final reportAsyncValue = ref.watch(medicalReportProvider);
    final wbController = WebViewController()
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(wrappedHtml);


    return Scaffold(
      appBar: commonNavBar('Appointment'),
      body: WebViewWidget(controller: wbController),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primary,
        onPressed: () async {

          await Printing.layoutPdf(
            onLayout: (format) async {
              final doc = await Printing.convertHtml(
                format: format,
                html: makeDesktopHtml(html), // inject your sanitized HTML here
              );
              return doc;
            },
          );

          // await Printing.layoutPdf(onLayout: (format) async {
          //   final body = makeDesktopHtml(html);
          //
          //   final pdf = pw.Document();
          //   final widgets = await w2p.HTMLToPdf().convert(body);
          //   pdf.addPage(pw.MultiPage(build: (context) => widgets));
          //   return await pdf.save();
          // });
        },
        child: Icon(Icons.print, color: MyColors.white,),
      ),
    );
  }
}

String makeDesktopHtml(String originalHtml) {
  // Remove any existing viewport meta tag
  final sanitizedHtml = originalHtml.replaceAll(
    RegExp(r'<meta name="viewport".*?>', caseSensitive: false),
    '',
  );

  // Wrap it with a desktop-like shell
  return '''
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=512"> <!-- Half of 1024 -->
    <style>
      html, body {
        margin: 0;
        padding: 10px;
        width: 100%;
        height: 50%;
      }
    </style>
  </head>
  <body>
    $sanitizedHtml
  </body>
</html>

  ''';
}
