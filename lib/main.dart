import 'package:chillyflix/HomeTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Fanart.dart';
import 'MoviesTab.dart';
import 'ShowsTab.dart';
import 'Trakt.dart';

void main() {
  return runApp(MyApp()); 
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Trakt>(create: (_) => Trakt()),
        Provider<Fanart>(create: (_) => Fanart()),
      ],
      child: Shortcuts(
        // needed for AndroidTV to be able to select
        shortcuts: {LogicalKeySet(LogicalKeyboardKey.select): const Intent(ActivateAction.key)},
        child: MaterialApp(
          title: 'ChillyFlix',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            backgroundColor: Color.fromARGB(255, 35, 40, 50)
          ),
          home: MyHomePage(title: 'ChillyFlix'),
        ),
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 35, 40, 50),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: <Widget>[
                Text(widget.title),
                SizedBox(width: 50),
                TabBar(
                  isScrollable: true,
                  indicatorColor: Color.fromARGB(255, 255, 60, 70),
                  tabs: <Widget>[
                    Tab(text: 'Home'),
                    Tab(text: 'Movies'),
                    Tab(text: 'Shows'),
                  ],
                )
              ],
            ),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search),onPressed: () {}),
              IconButton(icon: Icon(Icons.settings),onPressed: () {}),
            ],
          ),
          body: Center(
            child: TabBarView(
              children: <Widget>[
                HomeTab(),
                MoviesTab(),
                ShowsTab(),
              ],
            ),
          ),
        ),
    );
  }
}
