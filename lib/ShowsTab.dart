import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Cover.dart';
import 'TraktItem.dart';
import 'Trakt.dart';

class ShowsTab extends StatefulWidget {
  @override
  _ShowsTabState createState() => _ShowsTabState();
}

class _ShowsTabState extends State<ShowsTab> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureProvider<List<Show>>(
        create: (_) {return Provider.of<Trakt>(context).getShows(24);},
        child: Consumer<List<Show>>(
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

  Widget createListView(BuildContext context, List<Show> values) {

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6, childAspectRatio: 0.55),
      itemCount: values.length,

      itemBuilder: (BuildContext context, int index) {
        Show item = values[index];
        return Cover(item: item);
      },
    );

  }

}

