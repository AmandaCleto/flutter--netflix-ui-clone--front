import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiCreditData {
  final List cast;
  final List crew;

  ApiCreditData({
    required this.cast,
    required this.crew,
  });

  factory ApiCreditData.fromJson(Map<String, dynamic> json) {
    return ApiCreditData(
      cast: json['cast'],
      crew: json['crew'],
    );
  }
}

Future<ApiCreditData> creditDataFetch(api) async {
  final response = await http.get(Uri.parse(api));

  if (response.statusCode == 200) {
    return ApiCreditData.fromJson(convert.jsonDecode(response.body));
  } else {
    throw Exception('Erro no carregar os dados');
  }
}
