import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'components/appBar.dart';
import '../../data/homeEmphasisData.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;
  bool hideTopAppBar = true;
  String teste = '';
  String imgPath = 'https://image.tmdb.org/t/p/w500';

  late Future<ApiHomeEmphasisBanner> futureEmphasis;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);

    futureEmphasis = homeEmphasisDataFetch();
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

  bool showImageText = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print('oi');

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
                  width: size.width,
                  height: 600,
                  child: Stack(
                    children: [
                      FutureBuilder<ApiHomeEmphasisBanner>(
                        future: futureEmphasis,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Stack(
                              children: [
                                Container(
                                  height: size.height,
                                  width: size.width,
                                  child: Image.network(
                                    '$imgPath${snapshot.data!.banner}',
                                    fit: BoxFit.fill,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;

                                      return Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.blueAccent),
                                      );
                                    },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Text('Erros ocorreram!'),
                                  ),
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
                                              fontSize: 40,
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
                                              fontSize: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: snapshot.data!.genres
                                            .asMap()
                                            .map(
                                              (index, item) => MapEntry(
                                                index,
                                                Row(
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        text: item['name'],
                                                        style: TextStyle(
                                                          color: Colors.white,
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .values
                                            .toList(),
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
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
