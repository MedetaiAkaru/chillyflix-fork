import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'Fanart.dart';
import 'TraktItem.dart';

class Detail extends StatefulWidget {
  final TraktItem item;
  Detail(this.item);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
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
          body: Container(
            color: Colors.black,
            child: Stack(
              children: <Widget>[
                buildBackdropImage(context),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [Colors.black, Colors.transparent]
                    )
                  ),
                  child: buildItemDetails(),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget buildBackdropImage(BuildContext context) {
    return Stack(
      children: <Widget>[
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: widget.item.fanart.backDrop,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(color: Colors.black.withOpacity(0)),
          ),
        )
      ],
    );
  }

  Container buildItemDetails() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(child: Image.network(widget.item.fanart.poster)),
            Flexible(
              child: Column(
                children: <Widget>[
                  Text(widget.item.title, style: TextStyle(color: Colors.white, fontSize: 50),),
                  Text(widget.item.overview, style: TextStyle(color: Colors.white)),
                  FlatButton(onPressed: (){},child: Text('Button 1'),),
                  FlatButton(onPressed: (){},child: Text('Button 2'),),
                ],
              )
            )
        ],),
      ),
    );
  }
}