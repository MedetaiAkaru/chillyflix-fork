import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Cover.dart';
import 'TraktItem.dart';
import 'Trakt.dart';

class MoviesTab extends StatefulWidget {
  @override
  _MoviesTabState createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureProvider<List<Movie>>(
        create: (_) {return Provider.of<Trakt>(context).getMovies(24);},
        child: Consumer<List<Movie>>(
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

  Widget _buildGridView(BuildContext context, List<Movie> values) {

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6, childAspectRatio: 0.55),
      itemCount: values.length,

      itemBuilder: (BuildContext context, int index) {
        Movie item = values[index];
        return Cover(item: item);
      },
    );

  }

}

