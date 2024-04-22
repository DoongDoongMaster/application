import 'package:application/main.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/router.dart';
import 'package:application/widgets/home/music_list_body.dart';
import 'package:application/widgets/custom_dialog.dart';
import 'package:application/widgets/home/project_preview.dart';
import 'package:application/widgets/modal_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewProjectModal extends StatefulWidget {
  final MusicThumbnailViewData music;

  const NewProjectModal({
    super.key,
    required this.music,
  });

  @override
  State<NewProjectModal> createState() => _NewProjectModalState();
}

class _NewProjectModalState extends State<NewProjectModal> {
  String _previewText = "";

  @override
  void initState() {
    super.initState();
    _previewText = widget.music.title;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onSubmit(BuildContext ctx) {
    database
        .addNewProject(_previewText, widget.music.id)
        .then((value) => ctx.pushReplacementNamed(RouterPath.home.name));
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      height: 300,
      child: Column(
        children: [
          ModalHeader(title: '새로운 연습', onComplete: () => onSubmit(context)),
          const Divider(height: 0),
          const Spacer(),
          IgnorePointer(
            ignoring: true,
            child: ProjectPreview(
              data: ProjectThumbnailViewData(
                id: '',
                type: widget.music.type,
                title: _previewText,
                isLiked: false,
                unreadCount: 0,
                createdAt: DateTime.now(),
              ),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 225,
            child: ModalTextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  _previewText = value;
                });
              },
              onSaved: (_) => onSubmit(context),
              initialValue: widget.music.title,
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}

class NewMusicModal extends StatefulWidget {
  final MusicInfo initialMusicInfo;

  const NewMusicModal({
    super.key,
    required this.initialMusicInfo,
  });

  @override
  State<NewMusicModal> createState() => _NewMusicModalState();
}

class _NewMusicModalState extends State<NewMusicModal> {
  final _formKey = GlobalKey<FormState>();

  String title = "";
  String artist = "";
  int bpm = 0;

  @override
  void initState() {
    super.initState();
    title = widget.initialMusicInfo.title;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      height: 350,
      child: Column(
        children: [
          ModalHeader(
              title: '새로운 악보',
              onComplete: () {
                if (_formKey.currentState!.validate()) {
                  database
                      .addNewMusic(widget.initialMusicInfo
                          .copyWith(title: title, artist: artist, bpm: bpm))
                      .then((value) {
                    context.pop(true);
                  });
                }
              }),
          const Divider(height: 0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IgnorePointer(
                  ignoring: true,
                  child: MusicPreview(
                    music: MusicThumbnailViewData(
                      id: "",
                      type: MusicType.user,
                      title: title,
                      artist: artist,
                      sheetImage: widget.initialMusicInfo.sheetImage!,
                      createdAt: DateTime.now(),
                    ),
                  ),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ModalTextFieldWithLabel(
                        label: '제목',
                        onChanged: (v) {
                          setState(() {
                            title = v;
                          });
                        },
                        initialValue: title,
                      ),
                      const SizedBox(height: 15),
                      ModalTextFieldWithLabel(
                        label: '아티스트',
                        onChanged: (v) {
                          setState(() {
                            artist = v;
                          });
                        },
                        hintText: '이름 없는 아티스트',
                      ),
                      const SizedBox(height: 15),
                      ModalTextFieldWithLabel(
                        label: 'BPM',
                        validator: (v) {
                          if (v != null) {
                            bpm = int.tryParse(v) ?? 0;
                            if (bpm > 0) {
                              return null;
                            }
                          }
                          return '1 ~ 200까지 숫자를 입력해주세요.';
                        },
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
