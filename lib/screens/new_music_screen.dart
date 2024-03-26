import 'dart:convert';
import 'dart:io';

import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/router.dart';
import 'package:application/screens/home_screen.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/widgets/home/add_new_modal.dart';
import 'package:application/widgets/white_thin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class NewMusicScreen extends StatefulWidget {
  final String? fileName;
  final String? filePath;
  const NewMusicScreen(
      {super.key, required this.fileName, required this.filePath});

  @override
  State<NewMusicScreen> createState() => _NewMusicScreenState();
}

class _NewMusicScreenState extends State<NewMusicScreen> {
  InAppLocalhostServer localhostServer =
      InAppLocalhostServer(documentRoot: 'assets/web');

  late File file;
  late MusicInfo musicInfo;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startLocalhost();
  }

  startLocalhost() async {
    file = File(widget.filePath!);
    await localhostServer.start();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    localhostServer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteThinAppBar(
        title: widget.fileName!,
        leftText: "취소",
        rightText: "다음",
        onPressedLeftLabel: () => context.pop(),
        onPressedRightLabel: () => showDialog(
            context: context,
            builder: (context) =>
                NewMusicModal(initialMusicInfo: musicInfo)).then((value) {
          context.pop();
          context.pushReplacementNamed(RouterPath.home.name,
              queryParameters: {"tab": HomeTab.musicList.name});
        }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 40),
          if (localhostServer.isRunning())
            Expanded(
              child: Stack(
                children: [
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      boxShadow: [ShadowStyles.shadow200],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: SizedBox.expand(
                        child: InAppWebView(
                          initialUrlRequest: URLRequest(
                            url: WebUri('http://localhost:8080'),
                          ),
                          // onConsoleMessage: (controller, consoleMessage) =>
                          //     print(consoleMessage),
                          // onReceivedError: (controller, request, error) =>
                          //     print(error.description),
                          onWebViewCreated: (controller) async {
                            controller.addJavaScriptHandler(
                                handlerName: 'sendFileToOSMD',
                                callback: (args) async {
                                  return {
                                    'bytes':
                                        utf8.decode(await file.readAsBytes()),
                                    'name': file.path
                                  };
                                });
                            controller.addJavaScriptHandler(
                              handlerName: 'getDataFromOSMD',
                              callback: (args) {
                                setState(() {
                                  isLoading = false;
                                  musicInfo = MusicInfo(
                                      title: widget.fileName!,
                                      cursorList: List<Cursors>.from(args[0]
                                              ["cursorList"]
                                          .map((v) => Cursors.fromJson(v))),
                                      measureList: List<Cursors>.from(args[0]
                                              ["measureList"]
                                          .map((v) => Cursors.fromJson(v))),
                                      sheetImage:
                                          base64Decode(args[1].split(',')[1]),
                                      type: MusicType.user,
                                      sourceCount: {
                                        for (var v in DrumComponent.values)
                                          v.name: 10,
                                      });
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  if (isLoading) const LinearProgressIndicator(),
                ],
              ),
            )
        ],
      ),
    );
  }
}
