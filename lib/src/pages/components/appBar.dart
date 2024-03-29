import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatefulWidget {
  final double scrollOffset;
  final double scrollAmountAppBar;

  const CustomAppBar({
    Key? key,
    required this.scrollOffset,
    required this.scrollAmountAppBar,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late ScrollController _scrollViewController;

  bool isScrollingDown = false;

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black
          .withOpacity((widget.scrollOffset / 350).clamp(0, 1).toDouble()),
      child: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      flexibleSpace: Column(
                        children: [
                          Container(
                            height: widget.scrollAmountAppBar,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/netflix-logo.png",
                                    width: 25,
                                    fit: BoxFit.contain,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/transmit.svg',
                                        height: 21,
                                        width: 21,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      SizedBox(
                                        width: 22,
                                      ),
                                      SvgPicture.asset(
                                        'assets/icons/search.svg',
                                        height: 21,
                                        width: 21,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      SizedBox(
                                        width: 22,
                                      ),
                                      Container(
                                        height: 24,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(2),
                                          ),
                                          child: Image.asset(
                                            "assets/user-hero.png",
                                            height: 24,
                                            width: 24,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Séries',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Filmes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Categorias',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: SvgPicture.asset(
                                        'assets/icons/arrow-down.svg',
                                        height: 4,
                                        width: 4,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
