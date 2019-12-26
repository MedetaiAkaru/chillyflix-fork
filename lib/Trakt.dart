import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Movie.dart';

class Trakt {
  String apiVersion = '2';
  String baseUrl = 'https://api.trakt.tv';
  String apiKey = '0382d8815ebf303ee57a69a88b02348afaf40bcb39b7053da6bb2da36ee800a3';
  String secretKey = '078b464ad3d02eefb44c0259dea679b40074dbfef0fd01947c9b59fc546010de';

  Future<List<Movie>> getMovies() async {
    var res = await http.get('${baseUrl}/movies/trending?extended=full&limit=24', headers: {'trakt-api-version': apiVersion, 'trakt-api-key': apiKey});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Movie> movies = body
          .map(
            (dynamic item) => Movie.fromJson(item),
          )
          .toList();
      return movies;
    } else {
      throw "Can't get posts.";
    }
  }

}