import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiTop10Data {
  final List results;

  ApiTop10Data({
    required this.results,
  });

  factory ApiTop10Data.fromJson(Map<String, dynamic> json) {
    return ApiTop10Data(
      results: json['results'],
    );
  }
}

Future<ApiTop10Data> creditDataFetch(api) async {
  final response = await http.get(Uri.parse(api));

  if (response.statusCode == 200) {
    return ApiTop10Data.fromJson(convert.jsonDecode(response.body));
  } else {
    throw Exception('Erro no carregar dados');
  }
}
