String apiBase = 'https://api.themoviedb.org/3/';
String apiKey = 'api_key=b08d03e485967449e3ee8777025070fd';
String language = '&language=pt-BR';
String discover = 'discover/';
String getMovie = 'movie?';
String movieDetail = 'movie/';
String topRated = 'top_rated?';

String apiCarouselUrl({required int page, required String type}) {
  if (type == 'popular') {
    return '$apiBase${movieDetail}popular?$apiKey$language&page=$page';
  }

  if (type == 'top_rated') {
    return '$apiBase${movieDetail}top_rated?$apiKey$language&page=$page';
  }

  return 'Não foi possível retornar a URL da API';
}

String apiDeepUrl({required int id, required String type}) {
  if (type == 'detailed') {
    return '$apiBase$movieDetail$id?$apiKey$language';
  }

  if (type == 'cast') {
    return '$apiBase$movieDetail$id/credits?$apiKey$language';
  }

  return 'Não foi possível retornar a URL da API';
}
