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
  String message = '';
  late double scrollPosition;
  bool isScrollingDown = false;
  bool hideTopAppBar = true;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
      });
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        message = "reach the top";
      });
    }

    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        message = "descendo";
        hideTopAppBar = false;
      });
    }
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        message = "subindo";
        hideTopAppBar = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(hideTopAppBar ? 100.0 : 60.0),
        child: CustomAppBar(scrollOffset: 100, hideTopAppBar: hideTopAppBar),
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
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'aqui $message: ${scrollController.position.pixels}',
                    style: TextStyle(color: Colors.amber, fontSize: 20),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'lista',
                    style: TextStyle(color: Colors.amber, fontSize: 50),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'lista',
                    style: TextStyle(color: Colors.amber, fontSize: 50),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'lista',
                    style: TextStyle(color: Colors.amber, fontSize: 50),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'lista',
                    style: TextStyle(color: Colors.amber, fontSize: 50),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.red,
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
