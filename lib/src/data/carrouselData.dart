import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiCarrouselData {
  final int page;
  final List results;

  ApiCarrouselData({
    required this.page,
    required this.results,
  });

  factory ApiCarrouselData.fromJson(Map<String, dynamic> json) {
    return ApiCarrouselData(
      page: json['page'],
      results: json['results'],
    );
  }
}

Future<ApiCarrouselData> carrouselDataFetch(api, remove) async {
  final response = await http.get(Uri.parse(api));
  final cut = convert.jsonDecode(response.body);

  if (remove > 0) {
    cut['results'].removeRange(0, remove);
  }

  if (response.statusCode == 200) {
    return ApiCarrouselData.fromJson(cut);
  } else {
    throw Exception('Erro no carregar os dados');
  }
}
