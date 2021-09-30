import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';

class ApicarrouselData {
  final int page;
  final List results;

  ApicarrouselData({
    required this.page,
    required this.results,
  });

  factory ApicarrouselData.fromJson(Map<String, dynamic> json) {
    return ApicarrouselData(
      page: json['page'],
      results: json['results'],
    );
  }
}

Future<ApicarrouselData> carrouselDataFetch(api, limit) async {
  final response = await http.get(Uri.parse(api));
  final cutted = convert.jsonDecode(response.body);

  if (limit > 0) {
    cutted['results'].removeRange(0, limit);
  }

  if (response.statusCode == 200) {
    return ApicarrouselData.fromJson(cutted);
  } else {
    throw Exception('Erro no carregar os dados');
  }
}
