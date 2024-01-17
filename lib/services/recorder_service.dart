import 'dart:typed_data';

import 'package:record/record.dart';

class RecorderService {
  final _recorder = AudioRecorder();
  final String filePath;
  late Stream<Uint8List> stream;
  RecorderService({required this.filePath});

  Future<int> startRecord() async {
    // Check and request permission if needed
    // DateTime dt1 = DateTime.now();
    if (await _recorder.hasPermission()) {
      // Start recording to file
      await _recorder.start(const RecordConfig(), path: filePath);
    }
    return 0;
  }

  stopRecord() async {
    // Stop recording...
    await _recorder.stop();
    await _recorder.dispose();
  }
}
