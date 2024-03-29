import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_clone_netflix/src/config/config.dart';
import 'package:ui_clone_netflix/src/data/creditData.dart';
import 'package:ui_clone_netflix/src/data/detailedData.dart';
import 'package:ui_clone_netflix/src/pages/components/appBar.dart';
import 'package:ui_clone_netflix/src/pages/home/components/bottomSheet.dart';
import 'package:ui_clone_netflix/src/utils/apiUrl.dart';

import 'home/components/carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var API_KEY = '';
  String emphasisBannerApi = '';
  String emphasisBannerApiCredit = '';
  String IMAGE_PATH = '';

  bool hideTopAppBar = true;
  late ScrollController scrollController;
  double scrollAmountProfferedSize = 120.0;
  double scrollAmountAppBar = 80.0;

  //Futures
  late Future<ApiDetailedData> futureEmphasis;
  late ApiDetailedData detailedData;
  late ApiCreditData creditData;

  @override
  void initState() {
    super.initState();

    API_KEY = Config.getApiKey('API_KEY');
    IMAGE_PATH = Config.getApiKey('IMAGE_PATH');

    emphasisBannerApi =
        'https://api.themoviedb.org/3/movie/453071-the-day-naruto-became-hokage?api_key=$API_KEY&language=pt-BR';
    emphasisBannerApiCredit =
        'https://api.themoviedb.org/3/movie/635302-demon/credits?api_key=$API_KEY&language=pt-BR';

    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);

    futureEmphasis = detailedDataFetch(emphasisBannerApi);
  }

  fetchDetailedApi(context) async {
    detailedData = await detailedDataFetch(emphasisBannerApi);
    creditData = await creditDataFetch(emphasisBannerApiCredit);

    modalBottomSheet(
      context,
      itemDetailed: detailedData,
      itemCredit: creditData,
      indexTop10: -1,
    );
  }

  _scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        //descendo
        if (scrollAmountProfferedSize < 100) {
          scrollAmountProfferedSize += 1.0;
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

        if (scrollAmountProfferedSize > 60) {
          scrollAmountProfferedSize -= 1.0;
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
    String watchAgainApi = apiCarouselUrl(page: 20, type: 'popular');
    String mostPopularApi = apiCarouselUrl(page: 1, type: 'popular');
    String top10Api = apiCarouselUrl(page: 1, type: 'top_rated');
    print(top10Api);
    String nowPlayingApi = apiCarouselUrl(page: 2, type: 'now_playing');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(scrollAmountProfferedSize),
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
                                          '$IMAGE_PATH${snapshot.data!.poster_path}',
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
                                                  ..strokeWidth = 1
                                                  ..color = Color(0xFFFF7F01),
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
                  title: 'Assistir novamente',
                  apiSubject: watchAgainApi,
                ),
                SizedBox(
                  height: 30,
                ),
                Carousel(
                  title: 'Mais populares',
                  apiSubject: mostPopularApi,
                ),
                SizedBox(
                  height: 30,
                ),
                Carousel(
                  title: 'TOP 10 do dia',
                  apiSubject: top10Api,
                  remove: 10,
                  top10: true,
                ),
                SizedBox(
                  height: 30,
                ),
                Carousel(
                  title: 'Estão assistindo agora',
                  apiSubject: nowPlayingApi,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
