import 'dart:convert';

import 'package:chillyflix/TraktItem.dart';
import 'package:http/http.dart' as http;

class FanartItem {
  String poster;
  String backDrop;
  String logo;
  FanartItem({this.poster, this.backDrop, this.logo});
}

class Fanart {
  String fanartBaseUrl = 'http://webservice.fanart.tv/v3';
  String fanartApiKey = 'a24e36632e681ebb4b7763c606b0e2f7';
  String tmdbApiUrl = 'https://api.themoviedb.org/3';
  String tmdbApiKey = '7f278e56a85aa1aa3ead3db5cfffbc31';
  String tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';

  Future<FanartItem> getImages(TraktItem item) async {
    FanartItem fanart = FanartItem(poster: '', backDrop: '');
    
    List<String> fanarts = [];
    fanarts = await getImagesFromTmdb(_getTmdbEndpoint(item));
    fanart.poster = fanarts[0];
    fanart.backDrop = fanarts[1];
    if(fanart.poster == '' || fanart.backDrop == '') {
      print("fetching from fanart for ${item.title}");
      // fanarts = await getImagesFromTmdb(tmdbEndpoint);
      fanart.poster = await getImagesFromFanart(item.ids['imdb'], 'movies');
    }
    return fanart;
  }

  String _getTmdbEndpoint(TraktItem item) {
    switch(item.type) {
      case 'movie':
        return 'movie/${item.ids['tmdb'].toString()}';
      case 'show':
        return 'tv/${item.ids['tmdb'].toString()}';
      case 'season':
        return 'tv/${item.ids['tmdb'].toString()}/season/1';
      case 'episode':
        return 'tv/${item.ids['tmdb'].toString()}/season/1/episode/1';
    }
  }


  Future<String> getImagesFromFanart(String imdbId, String endpoint) async {
    String posterArray = endpoint == 'movies' ? 'movieposter' : 'tvposter';
    print('${fanartBaseUrl}/${endpoint}/${imdbId}?api_key=${fanartApiKey}');
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


  Future<List<String>> getImagesFromTmdb(String endpoint) async {
    var res = await http.get('${tmdbApiUrl}/${endpoint}?api_key=${tmdbApiKey}');
    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return [tmdbImageUrl + body['poster_path'], tmdbImageUrl + body['backdrop_path']];
      // return tmdbImageUrl + body[type][0]['file_path'];
      
    } else {
      return ['', ''];
    }
  }

  

}

