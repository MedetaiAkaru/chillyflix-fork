import 'package:chillyflix/Pages/SettingsPage.dart';
import 'package:chillyflix/Tabs/HomeTab.dart';
import 'package:chillyflix/Tabs/ShowsTab.dart';
import 'package:chillyflix/Tabs/MoviesTab.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              IconButton(icon: Icon(Icons.search),onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));}),
              IconButton(icon: Icon(Icons.settings),onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));}),
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
