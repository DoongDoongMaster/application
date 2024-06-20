import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static const String env = String.fromEnvironment('env');

  static String serverHost = dotenv.env["API_URL"] ?? "";
  static String testServer = dotenv.env["TEST_URL"] ?? "";
}
