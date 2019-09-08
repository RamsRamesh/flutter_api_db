//import 'dart:core';
//
//class Movie {
//      String title;
//      String year;
//      String rated;
//      String released;
//      String director;
//      String language;
//      String country;
//      String awards;
//      String poster;
////      List<String> images;
//
//  Movie(
//      {
//        this.title,
//        this.year,
//        this.rated,
//        this.released,
//        this.director,
//        this.language,
//        this.country,
//        this.awards,
//        this.poster,
////        this.images,
//      });
//
//  Movie.map(dynamic obj) {
//    this.title = obj["Title"];
//    this.year = obj["Year"];
//    this.rated = obj["Rated"];
//    this.released = obj["Released"];
//    this.director = obj["Director"];
//    this.language = obj["Language"];
//    this.country = obj["Country"];
//    this.awards = obj["Awards"];
//    this.poster = obj["Poster"];
////    this.images = obj["Images"];
//  }
//
//  Map<String, dynamic> toMap() {
//    var map = new Map<String, dynamic>();
//    map["Title"] = title ?? "";
//    map["Year"] = year ?? "";
//    map["Released"] = released ?? "";
//    map["Director"] = director ?? "";
//    map["Rated"] = rated ?? "";
//    map["Language"] = language ?? "";
//    map["Country"] = country ?? "";
//    map["Awards"] = awards ?? "";
//    map["Poster"] = poster ?? "";
////    map["Images"] = images ?? "";
//    return map;
//  }
//
//  @override
//  String toString() {
//    return '{'
//        'Title:$title'
//        'Year:$year,'
//        'Director:$director,'
//        'Released:$released,'
//        'Country:$country,'
//        'Rated:$rated,'
//        'Language:$language,'
//        'Awards:$awards,'
//        'Poster:$poster,'
////        'Images:$images,'
//        '}';
//  }
//}

class MovieListModel {
  List<Movie> movie;

  MovieListModel({this.movie});

  MovieListModel.fromJson(Map<String, dynamic> json) {
    if (json['movie'] != null) {
      movie = new List<Movie>();
      json['movie'].forEach((v) {
        movie.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movie != null) {
      data['movie'] = this.movie.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movie {
  bool isChecked = false;
  String title;
  String year;
  String rated;
  String released;
  String runtime;
  String genre;
  String director;
  String writer;
  String actors;
  String plot;
  String language;
  String country;
  String awards;
  String poster;
  String metascore;
  String imdbRating;
  String imdbVotes;
  String imdbID;
  String type;
  String response;
  List<String> images;

  Movie(
      {this.title,
        this.year,
        this.rated,
        this.released,
        this.runtime,
        this.genre,
        this.director,
        this.writer,
        this.actors,
        this.plot,
        this.language,
        this.country,
        this.awards,
        this.poster,
        this.metascore,
        this.imdbRating,
        this.imdbVotes,
        this.imdbID,
        this.type,
        this.response,
        this.images});

  Movie.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    year = json['Year'];
    rated = json['Rated'];
    released = json['Released'];
    runtime = json['Runtime'];
    genre = json['Genre'];
    director = json['Director'];
    writer = json['Writer'];
    actors = json['Actors'];
    plot = json['Plot'];
    language = json['Language'];
    country = json['Country'];
    awards = json['Awards'];
    poster = json['Poster'];
    metascore = json['Metascore'];
    imdbRating = json['imdbRating'];
    imdbVotes = json['imdbVotes'];
    imdbID = json['imdbID'];
    type = json['Type'];
    response = json['Response'];
    images = json['Images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Year'] = this.year;
    data['Rated'] = this.rated;
    data['Released'] = this.released;
    data['Runtime'] = this.runtime;
    data['Genre'] = this.genre;
    data['Director'] = this.director;
    data['Writer'] = this.writer;
    data['Actors'] = this.actors;
    data['Plot'] = this.plot;
    data['Language'] = this.language;
    data['Country'] = this.country;
    data['Awards'] = this.awards;
    data['Poster'] = this.poster;
    data['Metascore'] = this.metascore;
    data['imdbRating'] = this.imdbRating;
    data['imdbVotes'] = this.imdbVotes;
    data['imdbID'] = this.imdbID;
    data['Type'] = this.type;
    data['Response'] = this.response;
    data['Images'] = this.images;
    return data;
  }
  @override
  String toString() {
    return '{'

        'Title:$title'
        'Year:$year,'
        'Director:$director,'
        'Released:$released,'
        'Country:$country,'
        'Rated:$rated,'
        'Language:$language,'
        'Awards:$awards,'
        'Poster:$poster,'
        'Images:$images,'
        'Writer:$writer,'
        'Actors:$actors,'
        'Plot:$plot,'
        'Metascore:$metascore,'
        'imdbRating:$imdbRating,'
        'imdbVotes:$imdbVotes,'
        'imdbID:$imdbID,'
        'Type:$type,'
        'Response:$response,'
        '}';
  }
}

