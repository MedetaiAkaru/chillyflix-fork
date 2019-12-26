import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Cover.dart';
import 'Fanart.dart';
import 'Movie.dart';

class Detail extends StatefulWidget {
  final Movie item;
  final Fanart fanart;
  Detail(this.item, this.fanart);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      // needed for AndroidTV to be able to select
      shortcuts: {LogicalKeySet(LogicalKeyboardKey.select): const Intent(ActivateAction.key)},
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Cover(item: widget.item, fanart: widget.fanart),
              Column(children: <Widget>[
                Text(widget.item.title),
                Text(widget.item.overview),
                FlatButton(onPressed: (){},child: Text('Button 1'),),
                FlatButton(onPressed: (){},child: Text('Button 2'),),
              ],)
          ],),
        ),
      ),
    );
  }
}