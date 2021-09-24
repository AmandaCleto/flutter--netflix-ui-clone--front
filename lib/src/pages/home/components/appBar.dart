import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppBar({
    this.scrollOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: _CustomAppBarMobile(),
    );
  }
}

class _CustomAppBarMobile extends StatefulWidget {
  @override
  __CustomAppBarMobileState createState() => __CustomAppBarMobileState();
}

class __CustomAppBarMobileState extends State<_CustomAppBarMobile> {
  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              children: <Widget>[
                AnimatedContainer(
                  height: _showAppbar ? 100.0 : 0.0,
                  width: MediaQuery.of(context).size.width,
                  duration: Duration(milliseconds: 200),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: Column(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/netflix-logo.png",
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/search.svg',
                                      height: 20,
                                      width: 20,
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                    SizedBox(
                                      width: 22,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      child: Image.asset(
                                        "assets/user-hero.png",
                                        height: 22,
                                        width: 22,
                                        fit: BoxFit.cover,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Séries',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Filmes',
                                style: TextStyle(color: Colors.white),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Categorias',
                                    style: TextStyle(color: Colors.white),
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
    );
  }
}
