import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'components/appBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String pathHomeImgPosterPath = '';
  Future fetch() async {
    var api =
        'https://api.themoviedb.org/3/discover/movie?api_key=b08d03e485967449e3ee8777025070fd&page=5](https://api.themoviedb.org/2/discover/movie?primary_release_date.gte=2014-09-15&primary_release_date.lte=2014-10-22&language=pt-BR';
    final Uri url = Uri.parse(api);
    final response = await http.get(url);
    final json = convert.jsonDecode(response.body);

    final imgPath =
        'https://image.tmdb.org/t/p/w500](https://image.tmdb.org/t/p/w500/)%7Bposter_path%7D[https://image.tmdb.org/t/p/w500](https://image.tmdb.org/t/p/w500/';

    final homeImgPosterPath = json['results'][6]['poster_path'];

    pathHomeImgPosterPath = '$imgPath$homeImgPosterPath';
    // print(pathHomeImgPosterPath);
  }

  late ScrollController scrollController;
  late double scrollPosition;
  bool isScrollingDown = false;
  bool hideTopAppBar = true;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  double scrollAmountPrefferedSize = 100.0;
  double scrollAmountAppBar = 60.0;

  _scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        //descendo
        // print(scrollController.position.pixels);
        if (scrollAmountPrefferedSize < 100) {
          scrollAmountPrefferedSize += 1.0;
        }

        if (scrollAmountAppBar < 60) {
          scrollAmountAppBar += 1.0;
        }

        hideTopAppBar = false;
      });
    }
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        //subindo

        if (scrollAmountPrefferedSize > 60) {
          scrollAmountPrefferedSize -= 1.0;
        }

        if (scrollAmountAppBar > 10) {
          scrollAmountAppBar -= 1.0;
        }

        hideTopAppBar = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(scrollAmountPrefferedSize),
        child: CustomAppBar(
          scrollOffset: 200,
          scrollAmountAppBar: scrollAmountAppBar,
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Flex(direction: Axis.horizontal, children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        'assets/home.jpg',
                      ),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'lista',
                    style: TextStyle(color: Colors.amber, fontSize: 50),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'aqui $scrollAmountPrefferedSize',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'lista',
                    style: TextStyle(color: Colors.amber, fontSize: 50),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'lista',
                    style: TextStyle(color: Colors.amber, fontSize: 50),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'lista',
                    style: TextStyle(color: Colors.amber, fontSize: 50),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'lista',
                    style: TextStyle(color: Colors.amber, fontSize: 50),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'lista',
                    style: TextStyle(color: Colors.amber, fontSize: 50),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
