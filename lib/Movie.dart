class Movie {
  String title;
  String overview;
  int runtime;
  String trailer;
  double rating;
  int year;
  Map<String, dynamic> ids;

  Movie({
    this.title,
    this.year,
    this.overview,
    this.trailer,
    this.runtime,
    this.rating,
    this.ids,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['movie']['title'] as String,
      year: json['movie']['year'] as int,
      overview: json['movie']['overview'] as String,
      runtime : json['movie']['runtime'] as int,
      trailer: json['movie']['trailer'] as String,
      rating: json['movie']['rating'] as double,
      ids: json['movie']['ids'] as Map<String, dynamic>
    );
  }

}