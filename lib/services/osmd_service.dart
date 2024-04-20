import 'dart:convert';
import 'dart:typed_data';

import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/scored_entry_convertor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class OSMDService {
  InAppLocalhostServer localhostServer =
      InAppLocalhostServer(documentRoot: 'assets/web');
  HeadlessInAppWebView? headlessWebView;
  void Function(String base64Image, Map<String, dynamic>? json) callback;

  OSMDService({required this.callback});

  run({
    required Uint8List xmlData,
    List<ScoredEntry>? transcription,
  }) async {
    await localhostServer.start();

    headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri('http://localhost:8080')),
      initialSize: const Size(1024, 0),
      // onConsoleMessage: (controller, consoleMessage) => print(consoleMessage),
      // onReceivedError: (controller, request, error) => print(error.description),
      onWebViewCreated: (controller) async {
        controller.addJavaScriptHandler(
            handlerName: 'sendFileToOSMD',
            callback: (args) async {
              return {
                'bytes': utf8.decode(xmlData),
                'transcription': transcription == null
                    ? null
                    : {
                        for (var entry in transcription)
                          if (entry.key != null)
                            entry.key.toString():
                                AccuracyType.values.indexOf(entry.type),
                      },
              };
            });
        controller.addJavaScriptHandler(
          handlerName: 'getDataFromOSMD',
          callback: (args) {
            callback(args[0], args[1]);
            controller.dispose();
            localhostServer.close();
          },
        );
      },
    );
    headlessWebView?.run();
  }
}
