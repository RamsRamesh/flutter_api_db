//import 'dart:convert';
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'dart:async';
//
//import 'movie_model.dart';
//
//void main() => runApp(MaterialApp(
//    debugShowCheckedModeBanner: false,
//    home: HomePage()
//
//));
//
//
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  String url ="https://gist.githubusercontent.com/saniyusuf/406b843afdfb9c6a86e25753fe2761f4/raw/523c324c7fcc36efab8224f9ebb7556c09b69a14/Film.JSON";
//  List<Movie> data;
//  List<Movie> parsePosts(String responseBody) {
//
//
//
//    MovieListModel parsed =  MovieListModel.fromJson(json.decode(responseBody));
//     //json.decode(responseBody);
//
//    return parsed.movie;
//  }
//
//  Future<String> getJsonData() async{
//    var response  = await http.get(Uri.encodeFull(url),
//
//        headers: {
//          'Accept': 'application/json'
//        });
//    print(response.body);
//
//    setState(() {
//      print("Converted ${response.body}");
//      data = parsePosts("{\"movie\" : ${response.body}}");
//    });
//    return response.body;
//  }
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    this.getJsonData();
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Movies"),
//      ),
//      body: ListView.builder(
//
//        itemCount: data == null ? 0 : data.length,
//        itemBuilder: (BuildContext context, int index){
//
//          return new Container(
//            child: Center(child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//
//                Card(
//
//                    child:Column(
//                      children: <Widget>[
//                        Row(
//
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Container(
//                              child: Text( data[index].title),
//                              padding: EdgeInsets.all(15),
//
//                            ),
//                            Container(
//                              child: Text( data[index].year),
//                              padding: EdgeInsets.all(15),
//                            ),
//
//                          ],),
//
//                        Container(
//                          alignment: Alignment.center,
//                          child: Text(
//                              data[index].released
//                          ),
//                        )
//                      ],
//                    )
//
//                ),
//
//
//              ],
//
//            ),),
//          );
//        },
//      ),
//
//    );
//  }
//}


/////

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'movie_model.dart';
import 'movies_db.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Navigation Basics',
      routes: routes(context),
      debugShowCheckedModeBanner: false,
//      home:HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  String url =
//      "https://gist.githubusercontent.com/saniyusuf/406b843afdfb9c6a86e25753fe2761f4/raw/523c324c7fcc36efab8224f9ebb7556c09b69a14/Film.JSON";
//  List data;
//
//  Future<String> getJsonData() async {
//    var response = await http
//        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
//    print(response.body);
//    setState(() {
//      var convertedJsonData = json.decode(response.body);
//      data = convertedJsonData;
//    });
//    return "Success";
//  }


  String url ="https://gist.githubusercontent.com/saniyusuf/406b843afdfb9c6a86e25753fe2761f4/raw/523c324c7fcc36efab8224f9ebb7556c09b69a14/Film.JSON";
  List<Movie> data;
  MovieDataBaseHelper _dataBaseHelper;

  List<Movie> parsePosts(String responseBody) {



    MovieListModel parsed =  MovieListModel.fromJson(json.decode(responseBody));
     //json.decode(responseBody);

    return parsed.movie;
  }

  Future<String> getJsonData() async{
    var response  = await http.get(Uri.encodeFull(url),

        headers: {
          'Accept': 'application/json'
        });
    print(response.body);

    setState(() {
      print("Converted ${response.body}");
      data = parsePosts("{\"movie\" : ${response.body}}");

    });
    return response.body;
  }
  @override
  void initState() {
    // TODO: implement initState
    _dataBaseHelper = new MovieDataBaseHelper();

    super.initState();
    this.getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      leading: IconButton(icon:Icon(Icons.refresh), onPressed: (){
        getJsonData();
      },),
      title: Center(child: Text("Movies")),
      actions: <Widget>[IconButton(icon:Icon(Icons.delete), onPressed: (){
        List<Movie> deletedList;
        deletedList = data.where((i) => i.isChecked == true).toList();
        print('count ${deletedList.length}');
      },
      )],),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Card(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Text(data[index].title),
                                        padding: EdgeInsets.all(15),
                                      ),
                                      Container(
                                        child: Text(data[index].year),
                                        padding: EdgeInsets.all(15),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(data[index].released),
                                  )
                                ],
                              )),
                          onTap: () {
                            Navigator.push(
                                context,
                                SlideRightRoute(
                                    page: SecondRoute(
                                      list: data,
                                      index: index,
                                    )));
                          },
                        ),
                      ),
                      Container(
                        child: Checkbox(
                          value: data[index].isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              data[index].isChecked = !data[index].isChecked;
                              print('Hello ........${data[index].isChecked}');

                            });
                          },
                        ),)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

routes(BuildContext context) {
  return <String, WidgetBuilder>{
    '/': (context) => HomePage(),
    '/second': (context) => SecondRoute(),
  };
}

class SecondRoute extends StatelessWidget {
  final List<Movie> list;
  final int index;

  SecondRoute({this.list, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: Text("Movie Description"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    list[index].title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '(',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(list[index].year,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20)),
                  Text(
                    ')',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(list[index].imdbRating,
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text(list[index].runtime,
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text(list[index].released,
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text(list[index].genre,
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
              Container(
                  height: 300,
                  width: 300,
                  child: Image.network(list[index].images[1])),
              Wrap(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(list[index].plot,
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  )
                ],
              ),
              details('Director'),
              details('Writer'),
              details('Awards'),
              details('Actors')
            ],
          ),
        ),
      ),
    );
  }

  Wrap details(String input) {
    print("$input");
    return Wrap(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("$input :  ",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                Flexible(
                    child: Text(list[index].actors,
                        style: TextStyle(color: Colors.white, fontSize: 15)))
              ],
            ),
          ),
        )
      ],
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({this.page})
      : super(
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) =>
      page,
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) =>
          SlideTransition(
              position: Tween<Offset>(
                  begin: const Offset(1, 1), end: Offset.zero)
                  .animate(animation),
              child: child));
}
