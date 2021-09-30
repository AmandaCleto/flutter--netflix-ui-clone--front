import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiHomeData {
  final int page;
  final List results;

  ApiHomeData({
    required this.page,
    required this.results,
  });

  factory ApiHomeData.fromJson(Map<String, dynamic> json) {
    return ApiHomeData(
      page: json['page'],
      results: json['results'],
    );
  }
}

Future<ApiHomeData> homeDataFetch(api, limit) async {
  final response = await http.get(Uri.parse(api));
  final cutted = convert.jsonDecode(response.body);

  if (limit > 0) {
    cutted['results'].removeRange(0, limit);
  }

  if (response.statusCode == 200) {
    return ApiHomeData.fromJson(cutted);
  } else {
    throw Exception('Erro no carregar dados');
  }
}
