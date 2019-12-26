import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'Fanart.dart';
import 'Movie.dart';

class Cover extends StatelessWidget {
  const Cover({
    Key key,
    @required this.item,
    @required this.fanart,
    // @required this.hasFocus,
  }) : super(key: key);

  final Movie item;
  final Fanart fanart;
  // final bool hasFocus;

  @override
  Widget build(BuildContext context) {

    return FutureProvider<String>(
      create: (_) {return fanart.getImagesFromTmdb(item.ids['tmdb']);},
      child: Consumer<String>(
        builder: (context,data,_) {
          if(data != null) {
            return Image.network(data, height: 300);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}