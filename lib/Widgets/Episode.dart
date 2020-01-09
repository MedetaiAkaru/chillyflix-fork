import 'package:chillyflix/Services/FanartService.dart';
import 'package:chillyflix/Services/TraktService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';


  class Episode extends StatefulWidget {

    const Episode({
    Key key,
    @required this.item,
    }) : super(key: key);

    final TraktModel item;


    @override
    _EpisodeState createState() => _EpisodeState();
  }
  
  class _EpisodeState extends State<Episode> with SingleTickerProviderStateMixin {

    FocusNode _node;
    AnimationController _controller;
    CurvedAnimation _animation;
    Color _focusColor;
    Color _textColor;
    
    @override
    void initState() {
      _focusColor = Colors.black.withAlpha(100);
      _textColor = Colors.white;
      _node = FocusNode();
      _node.addListener(_onFocusChange);

      _controller = AnimationController(duration: const Duration(milliseconds: 100), vsync: this, lowerBound: 0.95, upperBound: 1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

      super.initState();
    }

    void _onFocusChange() {
      if(_node.hasFocus) {
        _controller.forward();
        setState(() {
          _focusColor = Colors.white;
          _textColor = Colors.black;
        });
      } else {
        _controller.reverse();
        setState(() {
          _focusColor = Colors.black.withAlpha(100);
          _textColor = Colors.white;
        });
      }
    }

    @override
    void dispose() {
      _controller.dispose();
      _node.dispose();
      super.dispose();
    }

    @override
      Widget build(BuildContext context) {

        return Focus(
          focusNode: _node,
          child: ScaleTransition(
            scale: _animation,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: _focusColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 7,
                    offset: Offset(1, 5),
                  )
                ]
              ),
              // color: _focusColor,
              height: 77,
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5),),
                      child: buildStillImage(context)
                    ),
                  ),

                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Align(alignment: Alignment.topLeft, child: Text("S${widget.item.seasonNumber}E${widget.item.number} - ${widget.item.title}", style: TextStyle(fontWeight: FontWeight.w700, color: _textColor, fontSize: 10),)),
                          Align(alignment: Alignment.topLeft, child: Text(widget.item.overview, style: TextStyle(color: _textColor, fontSize: 7, height: 1.5), maxLines: 2,)),
                          Align(alignment: Alignment.topLeft, child: Text(widget.item.firstAired, style: TextStyle(color: _textColor, fontSize: 7, height: 1.5))),
                          // Align(alignment: Alignment.topLeft, child: Text(episode.runtime.to)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
     }


    FutureProvider<FanartItem> buildStillImage(BuildContext context) {
      return FutureProvider<FanartItem>(
        create: (_) => Provider.of<FanartService>(context).getImages(widget.item),
        child: Consumer<FanartItem>(
          builder: (context, fanart, _) {
            if(fanart != null && fanart.still != null) {
              widget.item.fanart = fanart;
              return FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: widget.item.fanart.still,
                // height: 250,
               fit: BoxFit.fill,
              );
            } else {
              return Image.memory(kTransparentImage, fit: BoxFit.fill);
            }
          },
        ),
      );
    }



  }