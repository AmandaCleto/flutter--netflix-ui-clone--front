import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiHomeData {
  final int page;
  // final String title;
  // final List genres;

  ApiHomeData({
    required this.page,
  });

  factory ApiHomeData.fromJson(Map<String, dynamic> json) {
    return ApiHomeData(
      page: json['page'],
    );
  }
}

Future<ApiHomeData> homeDataFetch(api) async {
  final response = await http.get(Uri.parse(api));

  if (response.statusCode == 200) {
    return ApiHomeData.fromJson(convert.jsonDecode(response.body));
  } else {
    throw Exception('Erro no carregar dados do banner principal');
  }
}
