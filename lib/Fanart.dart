import 'dart:convert';

import 'package:http/http.dart' as http;

class Fanart {
  String fanartBaseUrl = 'http://webservice.fanart.tv/v3';
  String fanartApiKey = 'a24e36632e681ebb4b7763c606b0e2f7';
  String tmdbApiUrl = 'https://api.themoviedb.org/3';
  String tmdbApiKey = '7f278e56a85aa1aa3ead3db5cfffbc31';
  String tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';




  Future<String> getImagesFromTmdb(int tmdbId) async {
    var res = await http.get('${tmdbApiUrl}/movie/${tmdbId}/images?api_key=${tmdbApiKey}');
    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      for(int i = 0; i < body['posters'].length; i++) {
        if(body['posters'][i]['iso_639_1'] == 'en') {
          return tmdbImageUrl + body['posters'][i]['file_path'];
        }
      }
      
    } else {
      return '';
    }

    return '';
  }

}

