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
  String pathHomeImgPosterPath = '';

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

  String teste = '';

  Future _getBannerApi() async {
    final apiHomeEmphasisBanner = ApiHomeEmphasisBanner();
    final emphasisBanner = await apiHomeEmphasisBanner.homeEmphasisDataFetch();

    setState(() {
      teste = emphasisBanner;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _getBannerApi();
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
                Stack(
                  children: [
                    Container(
                      height: 600,
                      child: Image.network(
                        teste,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Text('oi');
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 150,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            'Violet Evergarden',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                          Row(
                            children: [
                              Text(
                                'Animação',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              Text(
                                'Violet Evergarden',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              Text(
                                'Violet Evergarden',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
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
