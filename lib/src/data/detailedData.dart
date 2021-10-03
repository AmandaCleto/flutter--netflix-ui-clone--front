import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiDetailedData {
  final bool adult;
  final List genres;
  final String overview;
  final String title;
  final String release_date;
  final String poster_path;
  final String backdrop_path;
  final int runtime;
  final double vote_average;
  final int id;

  ApiDetailedData({
    required this.adult,
    required this.genres,
    required this.overview,
    required this.title,
    required this.release_date,
    required this.poster_path,
    required this.backdrop_path,
    required this.runtime,
    required this.vote_average,
    required this.id,
  });

  factory ApiDetailedData.fromJson(Map<String, dynamic> json) {
    return ApiDetailedData(
      adult: json['adult'] == null ? false : json['adult'],
      genres: json['genres'] == null ? [] : json['genres'],
      overview: json['overview'] == null ? '' : json['overview'],
      title: json['title'] == null ? '' : json['title'],
      release_date: json['release_date'] == null ? '' : json['release_date'],
      poster_path: json['poster_path'] == null ? '' : json['poster_path'],
      backdrop_path: json['backdrop_path'] == null ? '' : json['backdrop_path'],
      runtime: json['runtime'] == null ? 0 : json['runtime'],
      vote_average: json['vote_average'] == null ? 0.0 : json['vote_average'],
      id: json['id'] == null ? 0 : json['id'],
    );
  }
}

Future<ApiDetailedData> detailedDataFetch(api) async {
  final response = await http.get(Uri.parse(api));

  if (response.statusCode == 200) {
    return ApiDetailedData.fromJson(convert.jsonDecode(response.body));
  } else {
    throw Exception('Erro no carregar os dados');
  }
}
