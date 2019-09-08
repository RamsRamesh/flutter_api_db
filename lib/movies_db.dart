import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_api_db/movie_model.dart';

class MovieDataBaseHelper {
  /// Here we create the instance of the class at the time of declaring the static data member,
  /// so instance of the class is created at the time of classloading.
  /// It represents Singleton Design pattern of Early instantiation
  static final MovieDataBaseHelper _dataBaseHelperInstance =
      new MovieDataBaseHelper.internal();

  ///Private constructor, it will prevent to instantiate the Singleton class from outside the class.

  /// Using private constructor we can ensure that no more than one object can be created at a time.
  /// By providing a private constructor you prevent class instances from being created in any place other than this very class.
  MovieDataBaseHelper.internal();

  /// Use the factory keyword when implementing a constructor that doesn't always create a new instance of its class.
  /// For example, a factory constructor might return an instance from a cache, or it might return an instance of a subtype.
  factory MovieDataBaseHelper() => _dataBaseHelperInstance;

  /// Database table name and it should be final and it should not be changed. That's why we declared as final
  final String movieTable = 'Movie';

  /// Base class of Database from Sqflite plugin. It's an abstract class to send SQL commands for CRUD Operations
  static Database _movieDatabase;

  /// To perform asynchronous operations in Dart, you can use the Future class and the async and await keywords.
  ///
  /// refer to this link for better understanding of the Future, async and await keywords
  /// https://dart.dev/codelabs/async-await
  ///
  /// A future (lower case “f”) is an instance of the Future (capitalized “F”) class.
  /// A future represents the result of an asynchronous operation, and can have two states: uncompleted or completed.
  Future<Database> get db async {
    if (_movieDatabase != null) {
      return _movieDatabase;
    }
    _movieDatabase = await initDb();

    return _movieDatabase;
  }

  /// For async keyword, please refer to the below link
  /// https://dart.dev/guides/language/language-tour#asynchrony-support
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'movies.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  /// Method to create the DB with Database variable and Dbversion
  void _onCreate(Database db, int dbVersion) async {
    await db.execute(
        "CREATE TABLE $movieTable(id INTEGER PRIMARY KEY, firstName TEXT, "
        "lastName TEXT, password TEXT, reEnterPassword TEXT, mobileNumber TEXT, "
        "emailId TEXT, gender INTEGER, city TEXT, state TEXT, address TEXT)");
  }

  /// Method to insert the data into DB with insert query by passing table name and model data
  Future<int> saveAttendeesDetails(Movie movie) async {
    var dbClient = await db;
    int result = await dbClient.insert(movieTable, movie.toJson());
    return result;
  }
  /// Method to fetch all the user information from the Database using rawQuery
  Future<List<Movie>> getMovies() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Movie');
    List<Movie> movies = new List();
    for (int i = 0; i < list.length; i++) {
      var user = new Movie(
        title: list[i]["Title"],
        year: list[i]["Year"],
        rated: list[i]["Rated"],
        released: list[i]["Released"],
        runtime: list[i]["Runtime"],
        genre: list[i]["Genre"],
        director: list[i]["Director"],
        writer: list[i]["Writer"],
        actors: list[i]["Actors"],
        plot: list[i]["Plot"],
        language: list[i]["Language"],
        metascore: list[i]["Metascore"],
        imdbRating: list[i]["imdbRating"],
        imdbVotes: list[i]["imdbVotes"],
        imdbID: list[i]["imdbID"],
        type: list[i]["Type"],
        response: list[i]["Response"],
        images: list[i]["Images"]
      );
      movies.add(user);
    }
    print("DB data.... " + movies.toString());
    return movies;
  }

  /// Method to fetch all the user information from the Database using rawQuery
  Future<int> deleteMovie(Movie movie) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM Movie WHERE imdbID = ?', [movie.imdbID]);
    return res;
  }

  /// Method to delete all the user information from the Database using rawDelete
  Future<int> deleteAllMovies() async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM Movie');
    return res;
  }

  /// Method to update the attendees information using update query.
  Future<bool> update(Movie movie) async {
    print(movie.toJson());
    var dbClient = await db;
    int res = await dbClient.update("Movie", movie.toJson(),
        where: "imdbID = ?", whereArgs: <String>[movie.imdbID]);
    print(res);
    return res > 0 ? true : false;
  }

}
