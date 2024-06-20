import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
