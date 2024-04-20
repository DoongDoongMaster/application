import 'dart:io';

import 'package:application/models/entity/music_infos.dart';
import 'package:application/router.dart';
import 'package:application/screens/home_screen.dart';
import 'package:application/services/osmd_service.dart';
import 'package:application/widgets/home/add_new_modal.dart';
import 'package:application/widgets/music_sheet_viewer_widget.dart';
import 'package:application/widgets/white_thin_app_bar.dart';
import 'package:flutter/material.dart';
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
  MusicInfo? musicInfo;

  @override
  void initState() {
    super.initState();

    File(widget.filePath!).readAsBytes().then((bytes) {
      OSMDService osmd = OSMDService(
        callback: (base64Image, json) {
          setState(() {
            musicInfo = MusicInfo.fromJson(
              title: widget.fileName!,
              json: json!,
              base64String: base64Image,
              xmlData: bytes,
            );
          });
        },
      );
      osmd.run(xmlData: bytes);
    });
  }

  @override
  void dispose() {
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
        onPressedRightLabel: musicInfo == null
            ? null
            : () => showDialog(
                  context: context,
                  builder: (context) =>
                      NewMusicModal(initialMusicInfo: musicInfo!),
                ).then((value) {
                  if (value == true) {
                    context.pushReplacementNamed(RouterPath.home.name,
                        queryParameters: {"tab": HomeTab.musicList.name});
                  }
                }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              child: musicInfo == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : MusicSheetBox(
                      child: MusicSheetWidget(image: musicInfo!.sheetImage!)),
            ),
          )
        ],
      ),
    );
  }
}
