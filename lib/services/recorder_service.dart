import 'dart:typed_data';

import 'package:record/record.dart';

class RecorderService {
  late final AudioRecorder _recorder = AudioRecorder();
  late Stream<Uint8List> stream;
  bool isReady = false;
  RecorderService();

  Future<int> initialize() async {
    if (await _recorder.hasPermission()) {
      isReady = true;
      return 0;
    }
    return -1;
  }

  Future<int> startRecord(String path) async {
    // Check and request permission if needed
    // DateTime dt1 = DateTime.now();
    // Start recording to file
    // await _recorder.start(const RecordConfig(), path: path);
    stream = await _recorder
        .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));

    return 0;
  }

  Future<Stream<Uint8List>> stopRecord() async {
    if (await _recorder.isRecording()) {
      // Stop recording...
      await _recorder.stop();
    }
    return stream;
  }

  cancelRecord() async {
    if (await _recorder.isRecording()) {
      _recorder.stop();
    }
  }

  dispose() => _recorder.dispose();
}
