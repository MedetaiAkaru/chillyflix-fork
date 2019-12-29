import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';


import 'Detail.dart';
import 'Fanart.dart';
import 'TraktItem.dart';

class Cover extends StatefulWidget {
  const Cover({
    Key key,
    @required this.item,
  }) : super(key: key);

  final TraktItem item;

  @override
  _CoverState createState() => _CoverState();
}

class _CoverState extends State<Cover> with SingleTickerProviderStateMixin  {

  FocusNode _node;
  AnimationController _controller;
  Animation<double> _animation;
  int _focusAlpha = 100;

  Widget image;

  @override
  void initState() {
    _node = FocusNode();
    _node.addListener(_onFocusChange);
    _controller = AnimationController(duration: const Duration(milliseconds: 100), vsync: this, lowerBound: 0.9, upperBound: 1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _node.dispose();
    super.dispose();
  }

  void _onFocusChange() {
      if(_node.hasFocus) {
        setState(() {
          _focusAlpha = 200;
        });
        _controller.forward();
    } else {
        _controller.reverse();
        setState(() {
          _focusAlpha = 100;
        });
      }
    
  }


  @override
  Widget build(BuildContext context) {

    return Focus(
        onKey: _onKey,
        focusNode: _node,
        child: Builder(
          builder: (context) {
            return buildCover(context);
          }
        ),
    );
  }

  void _openDetails() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(widget.item)));
  }


  bool _onKey(FocusNode node, RawKeyEvent event) {
    if(event is RawKeyDownEvent) {
      if(event.logicalKey == LogicalKeyboardKey.enter) {
        _openDetails();
        return true;
      }
    }
    return false;
  }

  Widget buildCover(BuildContext context) {
    return  ScaleTransition(
      scale: _animation, 
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            child: buildPosterImage(context),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(_focusAlpha),
                  blurRadius: 20,
                  // spreadRadius: 1
                )
              ]
            ),
          ),
          SizedBox(height: 5),
          Align(child: Text(widget.item.title, maxLines: 1, style: TextStyle(color: Colors.white),), alignment: Alignment.topLeft,),
          Align(child: Text(widget.item.year.toString(), style: TextStyle(color: Color.fromARGB(70, 255, 255, 255), fontSize: 10)), alignment: Alignment.topLeft,),
        ],
      ),
    );
  }

  FutureProvider<FanartItem> buildPosterImage(BuildContext context) {
    return FutureProvider<FanartItem>(
      create: (_) => Provider.of<Fanart>(context).getImages(widget.item),
      child: Consumer<FanartItem>(
        builder: (context, data, _) {
          if(data != null) {
            widget.item.fanart = data;
            return FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: widget.item.fanart.poster,
              height: 250,
            );
          } else {
            return Image.memory(kTransparentImage, height: 250,);
          }
        },
      ),
    );
  }
}



