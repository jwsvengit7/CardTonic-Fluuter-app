import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String getBackendUrl() {
    return dotenv.env['BACKEND_URL'] ?? '';
  }

  static bool get debugMode {
    dotenv.load();
    return dotenv.env['DEBUG'] == 'true';
  }

}
