import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetaieldItemAppBar extends StatefulWidget {
  const DetaieldItemAppBar({
    Key? key,
  }) : super(key: key);

  @override
  _DetaieldItemAppBarState createState() => _DetaieldItemAppBarState();
}

class _DetaieldItemAppBarState extends State<DetaieldItemAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity((20 / 350).clamp(0, 1).toDouble()),
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
                      flexibleSpace: Container(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
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
