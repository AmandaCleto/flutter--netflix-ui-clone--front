import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/appBar.dart';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 100.0),
        child: CustomAppBar(scrollOffset: 20),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    // color: Colors.red,
                    height: 600,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.contain,
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
                      'lista',
                      style: TextStyle(color: Colors.amber, fontSize: 50),
                    ),
                  ),
                ],
              )

              // CustomScrollView(
              //   slivers: [
              //     SliverAppBar(
              //       toolbarHeight: 40,
              //       pinned: true,
              //       floating: true,
              //       brightness: Brightness.light,
              //       backgroundColor: Colors.transparent,
              //       excludeHeaderSemantics: false,
              //       flexibleSpace: FlexibleSpaceBar(
              //         collapseMode: CollapseMode.pin,
              //         background: Container(
              //           color: Colors.transparent,
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Row(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Image.asset(
              //                   "assets/netflix-logo.png",
              //                   width: 20,
              //                   fit: BoxFit.cover,
              //                 ),
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     SvgPicture.asset(
              //                       'assets/icons/search.svg',
              //                       height: 20,
              //                       width: 20,
              //                       allowDrawingOutsideViewBox: true,
              //                     ),
              //                     SizedBox(
              //                       width: 22,
              //                     ),
              //                     ClipRRect(
              //                       borderRadius: BorderRadius.all(
              //                         Radius.circular(2),
              //                       ),
              //                       child: Image.asset(
              //                         "assets/user-hero.png",
              //                         height: 20,
              //                         width: 20,
              //                         fit: BoxFit.cover,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       bottom: PreferredSize(
              //         preferredSize: Size.fromHeight(30),
              //         child: Container(
              //           height: 30,
              //           width: MediaQuery.of(context).size.width,
              //           color: Colors.transparent,
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceAround,
              //             children: [
              //               Text(
              //                 'Séries',
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //               Text(
              //                 'Filmes',
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //               Row(
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     'Categorias',
              //                     style: TextStyle(color: Colors.white),
              //                   ),
              //                   SizedBox(
              //                     width: 10,
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.only(top: 4),
              //                     child: SvgPicture.asset(
              //                       'assets/icons/arrow-down.svg',
              //                       height: 4,
              //                       width: 4,
              //                       allowDrawingOutsideViewBox: true,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              // SliverList(
              //   delegate: SliverChildListDelegate(
              //     <Widget>[
              //       Padding(
              //         padding: const EdgeInsets.only(top: 0),
              //         child: Container(
              //           color: Colors.blueAccent,
              //           height: 800,
              //           child: Column(
              //             children: [
              //               // Container(
              //               //   height: 200,
              //               //   width: MediaQuery.of(context).size.width,
              //               //   decoration: BoxDecoration(
              //               //     gradient: LinearGradient(
              //               //       colors: [Colors.black, Colors.transparent],
              //               //       begin: Alignment.bottomCenter,
              //               //       end: Alignment.topCenter,
              //               //     ),
              //               //     image: DecorationImage(
              //               //       fit: BoxFit.fitHeight,
              //               //       image: NetworkImage(
              //               //         pathHomeImgPosterPath,
              //               //       ),
              //               //     ),
              //               //   ),
              //               // ),
              //               Container(
              //                 color: Colors.red,
              //                 width: MediaQuery.of(context).size.width,
              //                 child: Text(
              //                   'lista',
              //                   style:
              //                       TextStyle(color: Colors.amber, fontSize: 50),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // )
              //   ],
              // ),
              ),
        ),
      ),
    );
  }
}