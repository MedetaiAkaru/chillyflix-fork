import 'package:flutter/material.dart';

import 'package:chillyflix/Widgets/Cover.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              child: Text('Movies trending', style: TextStyle(color: Colors.white, fontSize: 30),), alignment: Alignment.topLeft
            ),
          ),
          SizedBox(height: 20),
          CoverListView(context, 'movies'),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              child: Text('Shows trending', style: TextStyle(color: Colors.white, fontSize: 30),), alignment: Alignment.topLeft
            ),
          ),
          CoverListView(context, 'shows'),
        ],
      ),
    );
  }


   


}