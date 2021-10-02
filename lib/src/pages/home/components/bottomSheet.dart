import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/durationTime.dart';

modalBottomSheet(
  context, {
  required imgPath,
  required itemDetailed,
  required itemCredit,
  indexTop10 = -1,
}) {
  var size = MediaQuery.of(context).size;

  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: Color(0xFF2B2B2B),
    enableDrag: false,
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/detailedPage',
            arguments: [itemDetailed, itemCredit, imgPath, indexTop10]),
        child: Container(
          child: new Wrap(
            children: <Widget>[
              Container(
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.zero,
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 6),
                            width: 100,
                            height: 140,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (itemDetailed.backdrop_path != '')
                                      ? NetworkImage(
                                          '$imgPath${itemDetailed.backdrop_path}',
                                        )
                                      : AssetImage('assets/default-movie.png')
                                          as ImageProvider),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 24,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          itemDetailed.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        splashRadius:
                                            Material.defaultSplashRadius / 2,
                                        alignment: Alignment.topRight,
                                        splashColor: Colors.transparent,
                                        color: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        icon: SvgPicture.asset(
                                          'assets/icons/close-bottom-sheet.svg',
                                          height: 24,
                                          width: 24,
                                          allowDrawingOutsideViewBox: true,
                                        ),
                                        iconSize: 24,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      itemDetailed.release_date.substring(0, 4),
                                      style: TextStyle(
                                        color: Color(0xFF8D8D8D),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(
                                      itemDetailed.adult
                                          ? 'assets/icons/range-18.svg'
                                          : 'assets/icons/range-universal.svg',
                                      height: 20,
                                      width: 20,
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      durationToString(itemDetailed.runtime),
                                      style: TextStyle(
                                        color: Color(0xFF8D8D8D),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  itemDetailed.overview,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: TextStyle(
                                    color: Colors.white,
                                    height: 1.2,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Container(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 180,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/icons/play.svg',
                                  height: 14,
                                  width: 14,
                                  allowDrawingOutsideViewBox: true,
                                ),
                                label: const Text('Assistir'),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/download.svg',
                                    height: 20,
                                    width: 20,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  Text(
                                    'Download',
                                    style: TextStyle(
                                      color: Color(0xFF8D8D8D),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/arrow-right-outline.svg',
                                    height: 16,
                                    width: 16,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  Text(
                                    'Prévia',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: TextStyle(
                                      color: Color(0xFF8D8D8D),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                      color: Color(0xFF8D8D8D),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/info.svg',
                                    height: 20,
                                    width: 20,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Mais informações',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SvgPicture.asset(
                                'assets/icons/arrow-right.svg',
                                height: 16,
                                width: 16,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
