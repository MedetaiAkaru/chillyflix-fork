import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Cover.dart';
import 'Trakt.dart';
import 'TraktItem.dart';

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
          FutureProvider<List<TraktItem>>(
            create: (_) {return Provider.of<Trakt>(context).getMovies(6);},
            child: Consumer<List<TraktItem>>(
              builder: (context,data,_) {
                if(data != null) {
                  return createListView(context, data);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              child: Text('Shows trending', style: TextStyle(color: Colors.white, fontSize: 30),), alignment: Alignment.topLeft
            ),
          ),
          FutureProvider<List<TraktItem>>(
            create: (_) {return Provider.of<Trakt>(context).getShows(6);},
            child: Consumer<List<TraktItem>>(
              builder: (context,data,_) {
                if(data != null) {
                  return createListView(context, data);
                }
                return Text('loading');
              },
            ),
          ),
        ],
      ),
    );
  }


   Widget createListView(BuildContext context, List<TraktItem> values) {

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6, childAspectRatio: 0.55),
      itemCount: values.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        TraktItem item = values[index];
        return Cover(item: item);
      },
    );

  }


}