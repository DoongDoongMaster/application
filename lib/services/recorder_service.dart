import 'dart:typed_data';

import 'package:record/record.dart';

class RecorderService {
  final record = AudioRecorder();
  final String filePath;
  late Stream<Uint8List> stream;
  RecorderService({required this.filePath});

  Future<int> startRecord() async {
    // Check and request permission if needed
    // DateTime dt1 = DateTime.now();
    if (await record.hasPermission()) {
      // Start recording to file
      await record.start(const RecordConfig(), path: filePath);
    }
    // DateTime dt2 = DateTime.now();
    // return dt1.microsecondsSinceEpoch - dt2.microsecondsSinceEpoch;
    return 0;
  }

  stopRecord() async {
    // Stop recording...
    await record.stop();
    await record.dispose();
  }
}
