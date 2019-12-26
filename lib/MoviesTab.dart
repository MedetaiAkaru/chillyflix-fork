import 'package:chillyflix/Fanart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'Cover.dart';
import 'Detail.dart';
import 'Movie.dart';
import 'Trakt.dart';

class MoviesTab extends StatefulWidget {
  @override
  _MoviesTabState createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {

  Trakt trakt = Trakt();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureProvider<List<Movie>>(
        create: (_) {return trakt.getMovies();},
        child: Consumer<List<Movie>>(
          builder: (context,data,_) {
            if(data != null) {
              return createListView(context, data);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }


  Widget createListView(BuildContext context, List<Movie> values) {
    Fanart fanart = Fanart();
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8, childAspectRatio: 0.67),
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          Movie item = values[index];
          return FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(item, fanart)));
            },
            padding: EdgeInsets.all(2),
            focusColor: Colors.red,
            child: Cover(item: item, fanart: fanart),
          );
          // return Focus(
          //     child: Builder(
          //       builder: (context) {
          //         bool hasFocus = Focus.of(context).hasFocus;
          //         return Cover(item: item, fanart: fanart, hasFocus: hasFocus);
          //       },
          //     )
          // );
        },
    );
  }




  // Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  //   List<Movie> values = snapshot.data;
  //   Fanart fanart = Fanart();
  //   return GridView.builder(
        
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8, childAspectRatio: 0.67),
  //       itemCount: values.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         Movie item = values[index];
  //         return FlatButton(
  //           onPressed: () {
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(item, fanart)));
  //           },
  //           padding: EdgeInsets.all(2),
  //           focusColor: Colors.red,
  //           child: Cover(item: item, fanart: fanart),
  //         );
  //         // return Focus(
  //         //     child: Builder(
  //         //       builder: (context) {
  //         //         bool hasFocus = Focus.of(context).hasFocus;
  //         //         return Cover(item: item, fanart: fanart, hasFocus: hasFocus);
  //         //       },
  //         //     )
  //         // );
  //       },
  //   );
  // }
}

