import 'package:chillyflix/HomeTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'MoviesTab.dart';
import 'ShowsTab.dart';
import 'Trakt.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      // needed for AndroidTV to be able to select
      shortcuts: {LogicalKeySet(LogicalKeyboardKey.select): const Intent(ActivateAction.key)},
      child: MaterialApp(
        title: 'ChillyFlix',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: MyHomePage(title: 'ChillyFlix'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    Trakt trakt = Trakt();
    trakt.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: 'Home'),
                  Tab(text: 'Movies'),
                  Tab(text: 'Shows'),
                ],
              )
            ),
            body: Center(
              child: TabBarView(children: <Widget>[
                HomeTab(),
                MoviesTab(),
                ShowsTab(),
              ],),
            ),
          ),
      );
  }
}
