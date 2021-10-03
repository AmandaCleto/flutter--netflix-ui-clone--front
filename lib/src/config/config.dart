import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static getApiKey(String code) => dotenv.env[code];
  static getImagePath(String url) => dotenv.env[url];
}
