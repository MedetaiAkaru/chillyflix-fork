import 'dart:convert';

import 'package:http/http.dart' as http;

import 'TraktService.dart';

class FanartItem {
  String poster;
  String backDrop;
  String still;
  FanartItem({this.poster, this.backDrop, this.still});
}

class FanartService {
  String fanartBaseUrl = 'http://webservice.fanart.tv/v3';
  String fanartApiKey = 'a24e36632e681ebb4b7763c606b0e2f7';
  String tmdbApiUrl = 'https://api.themoviedb.org/3';
  String tmdbApiKey = '7f278e56a85aa1aa3ead3db5cfffbc31';
  String tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';

  Future<FanartItem> getImages(TraktModel item) async {
    
      return await getImagesFromTmdb(_getTmdbEndpoint(item), true);
    
  }

  String _getTmdbEndpoint(TraktModel item) {
    switch(item.type) {
      case 'movie':
        return 'movie/${item.ids['tmdb'].toString()}';
      case 'show':
        return 'tv/${item.ids['tmdb'].toString()}';
      case 'season':
        return 'tv/${item.showIds['tmdb'].toString()}/season/${item.number}';
      case 'episode':
        return 'tv/${item.showIds['tmdb'].toString()}/season/${item.seasonNumber}/episode/${item.number}';
    }
    return '';
  }


  Future<String> getImagesFromFanart(String imdbId, String endpoint) async {
    String posterArray = endpoint == 'movies' ? 'movieposter' : 'tvposter';
    var res = await http.get('${fanartBaseUrl}/${endpoint}/${imdbId}?api_key=${fanartApiKey}');
    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      // for(int i = 0; i < body[posterArray].length; i++) {
      //   if(body[posterArray][i]['lang'] == 'en') {
          return  body[posterArray][0]['url'];
        // }
      // }
      
    } else {
      return '';
    }
  }


  Future<FanartItem> getImagesFromTmdb(String endpoint, bool isEpisode) async {
    var res = await http.get('${tmdbApiUrl}/${endpoint}?api_key=${tmdbApiKey}');
    FanartItem fa = FanartItem(poster: null, backDrop: null, still: null);
    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      if(body['still_path'] != null) {
        fa.still = tmdbImageUrl + body['still_path'];
      }
      if(body['poster_path'] != null) {
        fa.poster = tmdbImageUrl + body['poster_path'];
      }
      if(body['backdrop_path'] != null) {
        fa.backDrop = (tmdbImageUrl + body['backdrop_path']).replaceAll('w500', 'original');
      }
    }
    return fa;
  }

  

}

