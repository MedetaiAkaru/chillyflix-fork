import 'package:chillyflix/Pages/DetailPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chillyflix/Widgets/Cover.dart';
import 'package:chillyflix/Models/TraktModel.dart';
import 'package:chillyflix/Services/TraktService.dart';

class MoviesTab extends StatefulWidget {
  @override
  _MoviesTabState createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {

  // ScrollController _scrollController;

  @override
  void initState() {
    // _scrollController = new ScrollController(
    //   initialScrollOffset: 0.0,
    //   keepScrollOffset: true,
    // );
    super.initState();
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  // void _toEnd(int index, int items) {     
  //   var row = (index/6).floor();
  //   var scrollCursor = row * 250;
  //   // if(scrollCursor != cursor) cursor = scrollCursor;
  //   print("scrolloffset");
  //   print(_scrollController.offset);
  //   print("cursor");
  //   print(cursor);
  //   print("maxscroll");
  //   print(_scrollController.position.maxScrollExtent);
  //   _scrollController.animateTo(                                      // NEW
  //     scrollCursor.toDouble(),                     // NEW
  //     duration: const Duration(milliseconds: 300),                    // NEW
  //     curve: Curves.ease,                                             // NEW
  //   );                                                                // NEW
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureProvider<List<TraktModel>>(
        create: (_) {return Provider.of<TraktService>(context).getMovies(24);},
        child: Consumer<List<TraktModel>>(
          builder: (context,data,_) {
            if(data != null) {
              return _buildGridView(context, data);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildGridView(BuildContext context, List<TraktModel> values) {

    return OrientationBuilder(
      builder: (context, orientation) {
        int itemCount = orientation == Orientation.landscape ? 6 : 3;
        return GridView.builder(
          // controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: itemCount, childAspectRatio: 0.55),
          itemCount: values.length,

          itemBuilder: (BuildContext context, int index) {
            TraktModel item = values[index];
            return Cover(
              item: item, 
              onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(item)));},
              // onFocus: () {_toEnd(index, 4);}
            );
          },
        );
      },
    );

    

  }

}

