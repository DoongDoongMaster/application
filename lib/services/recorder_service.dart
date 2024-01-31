import 'dart:typed_data';

import 'package:record/record.dart';

class RecorderService {
  AudioRecorder _recorder = AudioRecorder();
  late Stream<Uint8List> stream;
  RecorderService();

  Future<int> startRecord(String filePath) async {
    _recorder = AudioRecorder();
    // Check and request permission if needed
    // DateTime dt1 = DateTime.now();
    if (await _recorder.hasPermission()) {
      // Start recording to file
      await _recorder.start(const RecordConfig(), path: filePath);
    }
    return 0;
  }

  stopRecord() async {
    if (await _recorder.isRecording()) {
      // Stop recording...
      await _recorder.stop();
      await _recorder.dispose();
    }
  }
}
