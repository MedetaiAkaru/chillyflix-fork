import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'FanartService.dart';

class TraktService {
  String apiVersion = '2';
  String baseUrl = 'https://api.trakt.tv';
  String apiKey = '0382d8815ebf303ee57a69a88b02348afaf40bcb39b7053da6bb2da36ee800a3';
  String secretKey = '078b464ad3d02eefb44c0259dea679b40074dbfef0fd01947c9b59fc546010de';

  Future<List<TraktModel>> getMovies(int limit) async {
    var res = await http.get('${baseUrl}/movies/trending?extended=full&limit=${limit}.toString()', headers: {'trakt-api-version': apiVersion, 'trakt-api-key': apiKey});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<TraktModel> movies = body
          .map(
            (dynamic item) => TraktModel.fromJson(item, 'movie'),
          )
          .toList();
      return movies;
    } else {
      print(res.statusCode);
      print(res.body);
      return List<TraktModel>();
    }
  }


  Future<List<TraktModel>> getShows(int limit) async {
    var res = await http.get('${baseUrl}/shows/trending?extended=full&limit=${limit.toString()}', headers: {'trakt-api-version': apiVersion, 'trakt-api-key': apiKey});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<TraktModel> shows = body
          .map(
            (dynamic item) => TraktModel.fromJson(item, 'show'),
          )
          .toList();
      return shows;
    } else {
      print(res.statusCode);
      print(res.body);
      return List<TraktModel>();
      // throw "Can't get posts.";
    }
  }

  Future<List<TraktModel>> getSeasons(TraktModel show) async {
    var res = await http.get('${baseUrl}/shows/${show.ids['trakt']}/seasons?extended=episodes,full', headers: {'trakt-api-version': apiVersion, 'trakt-api-key': apiKey});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<TraktModel> seasons = body
          .map(
            (dynamic item) => TraktModel.fromJson(item, 'season', show: show),
          )
          .toList();
      return seasons;
    } else {
      print(res.statusCode);
      print(res.body);
      return List<TraktModel>();
    }
  }

}





class TraktModel {

  String title;
  String type;
  String overview;
  int runtime;
  int number;
  int seasonNumber;
  String network;
  String trailer;
  String posterImage;
  String backgroundImage;
  double rating;
  String firstAired;
  int year;
  Map<String, dynamic> ids;
  Map<String, dynamic> showIds;
  FanartItem fanart;
  List<TraktModel> seasons;
  List<TraktModel> episodes;

  TraktModel({
    this.seasons,
    this.episodes,
    this.title,
    this.type,
    this.year,
    this.overview,
    this.trailer,
    this.number,
    this.seasonNumber,
    this.runtime,
    this.posterImage,
    this.firstAired,
    this.backgroundImage,
    this.rating,
    this.ids,
    this.showIds,
  });

  bool isMovie() {
    return this.type == 'movie';
  }

  bool isShow() {
      return this.type == 'show';
  }

  bool isSeason() {
      return this.type == 'season';
  }

  bool isEpisode() {
      return this.type == 'episode';
  }

  factory TraktModel.fromJson(Map<String, dynamic> json, String type, {TraktModel show}) {

    TraktModel item = TraktModel();

    if(type == 'movie' || type == 'show') {
      item.title = json[type]['title'] as String;
      item.type = type;
      item.year = json[type]['year'] as int;
      item.overview = json[type]['overview'] as String;
      item.runtime = json[type]['runtime'] as int;
      item.trailer = json[type]['trailer'] as String;
      item.rating = json[type]['rating'] as double;
      item.ids = json[type]['ids'] as Map<String, dynamic>;
    }

    if(type == 'season') {
      item.title = json['title'] as String;
      item.type = type;
      item.showIds = show.ids;
      item.number = json['number'] as int;
      if(json['first_aired'] != null) {
        item.year = DateTime.parse(json['first_aired']).year;
      } else {
        item.year = show.year;
      }
      
      item.overview = json['overview'] as String;
      item.runtime = json['runtime'] as int;
      item.trailer = json['trailer'] as String;
      item.rating = json['rating'] as double;
      item.ids = json['ids'] as Map<String, dynamic>;

      item.episodes = List<TraktModel>();
      
      for(int i = 0; i < json['episodes'].length; i++) {
        TraktModel episode = TraktModel();
        episode.title = json['episodes'][i]['title'] as String;
        episode.type = 'episode';
        episode.number = json['episodes'][i]['number'] as int;
        episode.seasonNumber = item.number;
        episode.showIds = show.ids;
        if(json['episodes'][i]['first_aired'] != null) {
          episode.year = DateTime.parse(json['episodes'][i]['first_aired']).year;
          episode.firstAired = new DateFormat("d.M.y").format(DateTime.parse(json['episodes'][i]['first_aired'])).toString();
          item.year = episode.year;
        } else {
          episode.year = item.year;
          episode.firstAired = '';
        }
        episode.overview = (json['episodes'][i]['overview'] != null ? json['episodes'][i]['overview'] : '') as String;
        
        episode.runtime = json['episodes'][i]['runtime'] as int;
        episode.trailer = json['episodes'][i]['trailer'] as String;
        episode.rating = json['episodes'][i]['rating'] as double;
        episode.ids = json['episodes'][i]['ids'] as Map<String, dynamic>;
        
        item.episodes.add(episode);

      }

    }

    return item;
    
  }

}