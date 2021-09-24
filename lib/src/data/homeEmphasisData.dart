import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

var pathHomeImgPosterPath = '';

class ApiHomeEmphasisBanner {
  Future<String> homeEmphasisDataFetch() async {
    var api =
        'https://api.themoviedb.org/3/tv/75214-violet-evergarden?api_key=b08d03e485967449e3ee8777025070fd&language=pt-BR';
    final Uri url = Uri.parse(api);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body);

      final imgPath = 'https://image.tmdb.org/t/p/w500';
      final imagePosterToken = json['poster_path'];
      final String urlImagePosterPath = '$imgPath$imagePosterToken';

      return urlImagePosterPath;
    } else {
      throw Exception('Erro no carregar a imagem principal');
    }
  }
}
