import 'package:chillyflix/Fanart.dart';

class TraktItem {

  String title;
  String type;
  String overview;
  int runtime;
  String trailer;
  String posterImage;
  String backgroundImage;
  double rating;
  int year;
  Map<String, dynamic> ids;
  FanartItem fanart;

}


class Movie with TraktItem {
  String title;
  String type;
  String overview;
  int runtime;
  String trailer;
  String posterImage;
  String backgroundImage;
  double rating;
  int year;
  Map<String, dynamic> ids;
  FanartItem fanart;

  Movie({
    this.title,
    this.type,
    this.year,
    this.overview,
    this.trailer,
    this.runtime,
    this.posterImage,
    this.backgroundImage,
    this.rating,
    this.ids,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['movie']['title'] as String,
      type: 'movie',
      year: json['movie']['year'] as int,
      overview: json['movie']['overview'] as String,
      runtime : json['movie']['runtime'] as int,
      trailer: json['movie']['trailer'] as String,
      rating: json['movie']['rating'] as double,
      ids: json['movie']['ids'] as Map<String, dynamic>
    );
  }

}


class Show with TraktItem {
  String title;
  String type;
  String overview;
  int runtime;
  String trailer;
  String posterImage;
  String backgroundImage;
  double rating;
  int year;
  Map<String, dynamic> ids;
  

  Show({
    this.title,
    this.type,
    this.year,
    this.overview,
    this.trailer,
    this.runtime,
    this.posterImage,
    this.backgroundImage,
    this.rating,
    this.ids,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      title: json['show']['title'] as String,
      type: 'show',
      year: json['show']['year'] as int,
      overview: json['show']['overview'] as String,
      runtime : json['show']['runtime'] as int,
      trailer: json['show']['trailer'] as String,
      rating: json['show']['rating'] as double,
      ids: json['show']['ids'] as Map<String, dynamic>
    );
  }

}