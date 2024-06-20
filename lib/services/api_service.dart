import 'dart:convert';
import 'dart:io';

import 'package:application/main.dart';
import 'package:application/models/convertors/music_entry_convertor.dart';
import 'package:application/models/environment.dart';
import 'package:http/http.dart' as http;

class ADTApiResponse {
  final List<MusicEntry> transcription;

  ADTApiResponse.fromJson(Map<String, dynamic> json)
      : transcription = List<MusicEntry>.from(
            json["result"].map((v) => MusicEntry.fromJson(v)));
}

class ApiService {
  static String baseUrl = Environment.serverHost;
  static Future<Map<String, String>> get defaultHeader async => {
        "Authorization": "Bearer ${await fbService.idToken}",
      };

  static Future<ADTApiResponse?> getADTResult(
      {required String dataPath}) async {
    try {
      print("uploading file... ${File(dataPath).path}");
      var file = await http.MultipartFile.fromPath('file', File(dataPath).path);

      var uri = Uri.parse('${ApiService.baseUrl}/models/adt/predict');

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          ...await defaultHeader,
          'Content-Type': 'multipart/form-data',
        })
        ..files.add(file);

      print("request url: ${request.url.toString()}, $dataPath");

      var response = await request.send();
      print("request, ${request.files}");
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        // 서버 응답 데이터를 JSON으로 파싱
        var jsonResponse = json.decode(responseBody);
        print(jsonResponse);
        return ADTApiResponse.fromJson(jsonResponse);
        // return ADTResultModel.fromJson({'instrument': [], 'rhythm': []});)
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

  static Future<double?> getParams(String key) async {
    var uri = Uri.parse('${ApiService.baseUrl}/models/adt/$key');
    try {
      var request = http.MultipartRequest('GET', uri)
        ..headers.addAll({
          ...await defaultHeader,
          'ngrok-skip-browser-warning': '1',
        });

      print("request key: ${request.url.toString()}");

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        // 서버 응답 데이터를 JSON으로 파싱
        var jsonResponse = json.decode(responseBody);
        print(jsonResponse);
        return jsonResponse;
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

  static Future<dynamic> getOMRResult(String dataPath) async {
    var uri = Uri.parse('${ApiService.baseUrl}/models/omr/predict');

    try {
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          ...await defaultHeader,
          'Content-Type': 'multipart/form-data',
        })
        ..files.add(
            await http.MultipartFile.fromPath('file', File(dataPath).path));
      print("request url: ${request.url.toString()}, $dataPath");

      var response = await request.send();
      print("request, ${request.files}");
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        // 서버 응답 데이터를 JSON으로 파싱
        var jsonResponse = json.decode(responseBody);
        return jsonResponse["result"];
        // return ADTResultModel.fromJson({'instrument': [], 'rhythm': []});)
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
