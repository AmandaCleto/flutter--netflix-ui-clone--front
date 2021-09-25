import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiHomeEmphasisBanner {
  final String banner;
  final String title;
  final List genres;

  ApiHomeEmphasisBanner({
    required this.banner,
    required this.title,
    required this.genres,
  });

  factory ApiHomeEmphasisBanner.fromJson(Map<String, dynamic> json) {
    return ApiHomeEmphasisBanner(
      banner: json['poster_path'],
      title: json['name'],
      genres: json['genres'],
    );
  }
}

Future<ApiHomeEmphasisBanner> homeEmphasisDataFetch() async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/tv/75214-violet-evergarden?api_key=b08d03e485967449e3ee8777025070fd&language=pt-BR'));

  if (response.statusCode == 200) {
    return ApiHomeEmphasisBanner.fromJson(convert.jsonDecode(response.body));
  } else {
    throw Exception('Erro no carregar dados do banner principal');
  }
}
