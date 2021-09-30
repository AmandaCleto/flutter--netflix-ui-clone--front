import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/detailedData.dart';
import '../../data/creditData.dart';

import '../components/appBar.dart';
import './components/carousel.dart';
import './components/bottomSheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hideTopAppBar = true;
  late ScrollController scrollController;
  double scrollAmountPrefferedSize = 120.0;
  double scrollAmountAppBar = 80.0;

  //Apis
  late String detailedApi = '';
  late String creditApi = '';

  String emphasisApi =
      'https://api.themoviedb.org/3/movie/635302-demon?api_key=b08d03e485967449e3ee8777025070fd&language=pt-BR';
  String emphasisApiCast =
      'https://api.themoviedb.org/3/movie/635302-demon/credits?api_key=b08d03e485967449e3ee8777025070fd&language=pt-BR';

  //parts of access from the url api
  String apiBase = 'https://api.themoviedb.org/3/';
  String apiKey = 'api_key=b08d03e485967449e3ee8777025070fd';
  String language = '&language=pt-BR';
  String discover = 'discover/';
  String getMovie = 'movie?';
  String movieDetail = 'movie/';
  String topRated = 'top_rated?';
  String imgPath = 'https://image.tmdb.org/t/p/w500';

  //Futures
  late Future<ApiDetailedData> futureEmphasis;
  late ApiDetailedData detailedData;
  late ApiCreditData creditData;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);

    futureEmphasis = detailedDataFetch(emphasisApi);
  }

  fetchDetailedApi(context) async {
    detailedData = await detailedDataFetch(emphasisApi);
    creditData = await creditDataFetch(emphasisApiCast);

    modalBottomSheet(context, imgPath, detailedData, creditData);
  }

  _scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        //descendo
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
    var size = MediaQuery.of(context).size;

    //carrousel apis
    String mostPopularApi =
        '${apiBase}${movieDetail}popular?${apiKey}${language}';
    String top10Api = '${apiBase}${movieDetail}top_rated?${apiKey}${language}';
    String movieApi1 =
        '${apiBase}${discover}${getMovie}${apiKey}${language}&page=10';

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
        scrollDirection: Axis.vertical,
        controller: scrollController,
        child: Flex(direction: Axis.horizontal, children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => fetchDetailedApi(context),
                  child: Container(
                    width: size.width,
                    height: 600,
                    child: Stack(
                      children: [
                        FutureBuilder<ApiDetailedData>(
                          future: futureEmphasis,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Stack(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: size.height,
                                        width: size.width,
                                        child: Image.network(
                                          '$imgPath${snapshot.data!.poster_path}',
                                          fit: BoxFit.fill,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;

                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Color(0xFFFE0000),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Text('Erros ocorreram!'),
                                        ),
                                      ),
                                      Container(
                                        height: size.height,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          gradient: LinearGradient(
                                            begin: FractionalOffset.topCenter,
                                            end: FractionalOffset.bottomCenter,
                                            colors: [
                                              Colors.grey.withOpacity(0.0),
                                              Colors.black,
                                            ],
                                            stops: [0.0, 1.0],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 70,
                                    left: 0,
                                    right: 0,
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Text(
                                              snapshot.data!.title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 36,
                                                foreground: Paint()
                                                  ..style = PaintingStyle.stroke
                                                  ..strokeWidth = 6
                                                  ..color = Color(0xFF445767),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!.title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 36,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: snapshot.data!.genres
                                              .asMap()
                                              .map(
                                                (index, item) => MapEntry(
                                                  index,
                                                  RichText(
                                                    text: TextSpan(
                                                      text: item['name'],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: index ==
                                                                  snapshot
                                                                          .data!
                                                                          .genres
                                                                          .length -
                                                                      1
                                                              ? ''
                                                              : '   •   ',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .values
                                              .toList(),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/add.svg',
                                                  height: 20,
                                                  width: 20,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Minha lista',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                                onPrimary: Colors.black,
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: () {},
                                              icon: SvgPicture.asset(
                                                'assets/icons/play.svg',
                                                height: 1,
                                                width: 14,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              ),
                                              label: const Text('Assistir'),
                                            ),
                                            Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/info.svg',
                                                  height: 20,
                                                  width: 20,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Saiba mais',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            return const CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Carousel(
                  title: 'Mais populares',
                  apiSubject: mostPopularApi,
                  imgPath: imgPath,
                  apiBase: apiBase,
                  movieDetail: movieDetail,
                  language: language,
                  apiKey: apiKey,
                ),
                SizedBox(
                  height: 30,
                ),
                Carousel(
                  title: 'TOP 10 de TODOS os Tempos',
                  apiSubject: top10Api,
                  imgPath: imgPath,
                  apiBase: apiBase,
                  movieDetail: movieDetail,
                  language: language,
                  apiKey: apiKey,
                  limit: 10,
                  top10: true,
                ),
                SizedBox(
                  height: 30,
                ),
                Carousel(
                  title: 'Filmes incríveis',
                  apiSubject: movieApi1,
                  imgPath: imgPath,
                  apiBase: apiBase,
                  movieDetail: movieDetail,
                  language: language,
                  apiKey: apiKey,
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
