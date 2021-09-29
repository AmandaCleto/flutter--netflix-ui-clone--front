import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiCreditData {
  final List cast;

  ApiCreditData({
    required this.cast,
  });

  factory ApiCreditData.fromJson(Map<String, dynamic> json) {
    return ApiCreditData(
      cast: json['cast'],
    );
  }
}

Future<ApiCreditData> creditDataFetch(api) async {
  final response = await http.get(Uri.parse(api));

  if (response.statusCode == 200) {
    return ApiCreditData.fromJson(convert.jsonDecode(response.body));
  } else {
    throw Exception('Erro no carregar dados');
  }
}
