import 'dart:convert';
import 'dart:io';

import 'package:application/models/play_result_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // static const baseUrl = 'https://de87-203-255-190-41.ngrok-free.app';
  static const baseUrl = 'https://25e0-175-211-79-74.ngrok-free.app';

  static Future<PlayResultModel> uploadFile(
      {required String filePath, required int bpm, required int delay}) async {
    print("uploading file...");
    print("delay!!! $delay");
    File file = File(filePath);

    // 서버 엔드포인트 URL 수정
    var uri = Uri.parse('$baseUrl/upload');
    try {
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'Content-Type': 'multipart/form-data',
          'ngrok-skip-browser-warning': '1',
          'bpm': bpm.toString(),
          'delay': delay.toString(),
        })
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        // 서버 응답 데이터를 JSON으로 파싱
        var jsonResponse = json.decode(responseBody);
        return PlayResultModel.fromJson(jsonResponse);
        // return PlayResultModel.fromJson({'instrument': [], 'rhythm': []});
      } else {
        print('파일 업로드 실패: ${response.reasonPhrase}');
        // throw Error();
        return PlayResultModel.fromJson({'instrument': [], 'rhythm': []});
      }
    } catch (error) {
      print('오류 발생: $error');
      return PlayResultModel.fromJson({'instrument': [], 'rhythm': []});
    }
  }
}
