import 'package:flutter/material.dart';
import '../models/character.dart';
import '../styleguide.dart';
import '../widgets/character_widget.dart';

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CharactersListScreenState();
  }
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: currentPage,
      keepPage: false
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.search),
            )
          ],
        ),
        body: SafeArea(

          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 8),
                  child: RichText(
                    text: const TextSpan(
                        children: [
                          TextSpan(
                              text: "Animals Kingdom", style: AppTheme.display1),
                          TextSpan(text: "\n"),
                          TextSpan(text: "Characters", style: AppTheme.display2),
                        ]
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      children:<Widget>[
                        for(var i = 0; i < characters.length; i++)
                          CharacterWidget(character: characters[i],pageController: _pageController, currentPage: i )
                      ]
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
