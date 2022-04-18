import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../models/character.dart';
import '../styleguide.dart';

class CharacterDetailScreen extends StatefulWidget {

  final double _expandedBottomSheet = 0;
  final double _collapsedBottomSheet = -250;
  final double _fullCollapsedBottomSheet = -330;

  final Character character;

  const CharacterDetailScreen({required this.character});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CharacterDetailScreenState();
  }
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> with AfterLayoutMixin<CharacterDetailScreen> {

  double _currentButtomSheet = -330;
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;


    // TODO: implement build
    return Scaffold(
      body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "background-${widget.character.name}",
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: widget.character.colors,
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft
                    )
                ),

              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16),
                    child: IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 40,
                      color: Colors.white.withOpacity(0.9),
                      onPressed: () {
                        Future.delayed(const Duration(milliseconds: 250) , () {
                          setState(() {
                            _currentButtomSheet = widget._fullCollapsedBottomSheet;
                          });
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Hero(
                        tag: "image-${widget.character.name}",
                        child: Image.asset(widget.character.imagePath,
                          height: screenHeight * 0.45,
                        ),
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8),
                      child: Hero(
                          tag: "name-${widget.character.name}",
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                                child: Text(widget.character.name,
                                  style: AppTheme.heading,)
                            ),
                          )
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                    child: Text(
                      widget.character.description,
                      style: AppTheme.subHeading,),
                  )
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              bottom: _currentButtomSheet,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: _onTap,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        height: 80,
                        child: Text(
                          "Clips",
                          style: AppTheme.subHeading.copyWith(
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _clipsWidget(),
                    ),
                  ],
                ),
              ),
            )
          ]
      ),
    );
  }

  _onTap(){
    setState(() {
      _currentButtomSheet = isCollapsed ? widget._expandedBottomSheet : widget._collapsedBottomSheet;
      isCollapsed = !isCollapsed;
    });
  }

  Widget _clipsWidget() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              roundedContainer(Colors.redAccent),
              SizedBox(height: 20,),
              roundedContainer(Colors.greenAccent),
            ],
          ),
          SizedBox(width: 16,),
          Column(
            children: <Widget>[
              roundedContainer(Colors.orangeAccent),
              SizedBox(height: 20,),
              roundedContainer(Colors.purple),
            ],
          ),
          SizedBox(width: 16,),
          Column(
            children: <Widget>[
              roundedContainer(Colors.grey),
              SizedBox(height: 20,),
              roundedContainer(Colors.blueGrey),
            ],
          ),
          SizedBox(width: 16,),
          Column(
            children: <Widget>[
              roundedContainer(Colors.lightGreenAccent),
              SizedBox(height: 20,),
              roundedContainer(Colors.pinkAccent),
            ],
          ),
          SizedBox(width: 16,),
          Column(
            children: <Widget>[
              roundedContainer(Colors.deepOrange),
              SizedBox(height: 20,),
              roundedContainer(Colors.lightBlueAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget roundedContainer(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isCollapsed = true;
        _currentButtomSheet = widget._collapsedBottomSheet;
      });
    });
  }
}



