import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';


import 'package:chillyflix/Services/TraktService.dart';
import 'package:chillyflix/Widgets/Cover.dart';
import 'package:chillyflix/Widgets/Episode.dart';

class DetailPage extends StatefulWidget {
  final TraktModel item;
  DetailPage(this.item);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {

  TabController tabController;

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
          fontFamily: GoogleFonts.openSans().fontFamily,
          
        ),
        home: Scaffold(
          body: Container(
            color: Colors.black,
            child: Stack(
              children: <Widget>[
                buildBackdropImage(context),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.black.withAlpha(230), Colors.transparent]
                    )
                  ),
                  child: buildItemDetails()
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
          image: (widget.item.fanart != null && widget.item.fanart.backDrop != null) ? widget.item.fanart.backDrop : kTransparentImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        // Positioned(
        //   top: 0,
        //   left: 0,
        //   bottom: 0,
        //   right: 0,
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        //     // child: Container(color: Colors.black.withOpacity(0)),
        //   ),
        // )
      ],
    );
  }

  Widget buildItemDetails() {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: <Widget>[
          Flexible(
            flex: 5,
            child: Column(
              children: <Widget>[
                Align(alignment: Alignment.topLeft, 
                  child: Text(widget.item.title, 
                    style: GoogleFonts.oswald(textStyle: TextStyle(color: Colors.white, fontSize: 50)),
                  )
                ),
                SizedBox(height: 40),
                Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Color.fromARGB(255, 255, 180, 10), size: 30,),
                    SizedBox(width: 10),
                    Text(widget.item.rating.toStringAsPrecision(2) + " / 10", style: TextStyle(color: Colors.white),),
                    SizedBox(width: 30),
                    Icon(Icons.timer, color: Colors.white, size: 30,),
                    SizedBox(width: 10),
                    Text(widget.item.runtime.toString() + " minutes", style: TextStyle(color: Colors.white),),
                    SizedBox(width: 30),
                    Text(widget.item.year.toString(), 
                    style: TextStyle(color: Colors.white),
                  )
                  ],
                ),
                SizedBox(height: 40),
                Align(alignment: Alignment.topLeft, 
                  child: SizedBox(
                      width: 400,
                      child: Text(widget.item.overview, maxLines: 10,
                      style: TextStyle(color: Colors.white, fontSize: 10, height: 1.5),
                      ),
                  )
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    if(widget.item.isMovie())
                      RaisedButton(onPressed: (){},child: Text('PLAY'),color: Color.fromARGB(255, 255, 60, 70),textColor: Colors.white,), SizedBox(width: 20),
                    FlatButton(onPressed: (){},child: Text('Trailer'), color: Colors.white, ),
                  ],
                ),
              ],
            )
          ),
          if(widget.item.isShow())
            Flexible(
              flex: 5,
              child: _buildSeasonsAndEpisodes(context),
            ),
          
          
          
          // }
      ],),
    );
  }





  Widget _buildSeasonsAndEpisodes(BuildContext context) {

    return FutureProvider<List<TraktModel>>(
      create: (_) {
          return Provider.of<TraktService>(context).getSeasons(widget.item);
      },
      child: Consumer<List<TraktModel>>(
        builder: (context,items,_) {
          if(items != null) {
            TabController _tabController = TabController(
              length: items.length,
              vsync: this
            );
            return Column(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 160,
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Container(child: 
                              Cover(item: items[index], 
                              onTap: () {
                                _tabController.animateTo(index);
                              },
                            ), width: 80, height: 160);
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      // child: TabBar(
                      //   controller: _tabController,
                      //   labelPadding: EdgeInsets.all(5),
                      //   isScrollable: true,
                      //   indicatorColor: Colors.white.withAlpha(0),
                      //   tabs: <Widget>[
                      //     for(var season in items) Container(child: Cover(item: season), width: 80, height: 160), 
                      //     // for(var season in items) Tab(text: season.title), 
                      //   ],
                      // ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    for(var season in items) episodeList(season.episodes, widget.item)
                  ],
                ),
              ),
              
            ],
              );
          }
          return Text('loading');
        },
      ),
    );
    
  }


  Widget episodeList(List<TraktModel> episodes, TraktModel show) {
    return ListView.builder(
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        return Episode(item: episodes[index]);
      },
    );
  }


}