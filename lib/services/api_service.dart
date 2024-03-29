import 'dart:convert';
import 'dart:io';

import 'package:application/models/adt_result_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://bab3-222-110-177-95.ngrok-free.app';

  static Future<ADTResultModel?> getADTResult(
      {required String dataPath, required int bpm}) async {
    print("uploading file... ${File(dataPath).path}");

    // 서버 엔드포인트 URL 수정
    var uri = Uri.parse('${ApiService.baseUrl}/test');
    try {
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'Content-Type': 'multipart/form-data',
          'ngrok-skip-browser-warning': '1',
          'bpm': bpm.toString(),
        })
        ..files.add(
            await http.MultipartFile.fromPath('file', File(dataPath).path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        // 서버 응답 데이터를 JSON으로 파싱
        var jsonResponse = json.decode(responseBody);
        return ADTResultModel.fromJson(jsonResponse);
        // return ADTResultModel.fromJson({'instrument': [], 'rhythm': []});
      } else {
        print('${response.statusCode}: ${response.reasonPhrase}');
        // throw Error();
        return null;
      }
    } catch (error) {
      print('오류 발생: $error');
      return null;
    }
  }
}
