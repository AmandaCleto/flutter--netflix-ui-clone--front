import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

import '../../../data/carrouselData.dart';
import '../../../data/detailedData.dart';
import '../../../data/creditData.dart';

import '../../../config/config.dart';

import '../../../utils/apiUrl.dart';

import './bottomSheet.dart';

class Carousel extends StatefulWidget {
  final String title;
  final String apiSubject;
  final int remove;
  final bool top10;

  const Carousel({
    Key? key,
    required this.title,
    required this.apiSubject,
    this.top10: false,
    this.remove: 0,
  }) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late String IMAGE_PATH = '';
  late String detailedApi = '';
  late String creditApi = '';

  //Futures
  late Future<ApiCarrouselData> futureSubject;
  late ApiDetailedData detailedData;
  late ApiCreditData creditData;

  @override
  void initState() {
    super.initState();
    IMAGE_PATH = Config.getApiKey('IMAGE_PATH');

    futureSubject =
        carrouselDataFetch(widget.apiSubject, widget.remove).then((value) {
      return value;
    });
  }

  openModalBottomSheet(context, {required itemId, required indexTop10}) async {
    detailedApi = apiDeepUrl(id: itemId, type: 'detailed');
    creditApi = apiDeepUrl(id: itemId, type: 'credit');

    detailedData = await detailedDataFetch(detailedApi);
    creditData = await creditDataFetch(creditApi);

    modalBottomSheet(
      context,
      itemDetailed: detailedData,
      itemCredit: creditData,
      indexTop10: indexTop10,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: Colors.black,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<ApiCarrouselData>(
                future: futureSubject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: widget.top10 ? 20.0 : 6.0),
                        child: Row(
                          children: snapshot.data!.results
                              .asMap()
                              .map((index, item) {
                                return MapEntry(
                                  index,
                                  GestureDetector(
                                    onTap: () {
                                      openModalBottomSheet(
                                        context,
                                        itemId: item['id'],
                                        indexTop10:
                                            widget.top10 ? index + 1 : -1,
                                      );
                                    },
                                    child: Container(
                                      height: 180,
                                      child: Indexer(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Indexed(
                                            index: 2,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                right: widget.top10 ? 26 : 6,
                                              ),
                                              width: 110,
                                              height: 160,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: ((item['poster_path'] !=
                                                              '' &&
                                                          item['poster_path'] !=
                                                              null))
                                                      ? NetworkImage(
                                                          '$IMAGE_PATH${item['poster_path']}',
                                                        )
                                                      : AssetImage(
                                                              'assets/default-movie.png')
                                                          as ImageProvider,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                          index == 0
                                              ? SizedBox.shrink()
                                              : Indexed(
                                                  index: 4,
                                                  child: widget.top10
                                                      ? Positioned(
                                                          bottom: -10.0,
                                                          left: -28.0,
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                height:
                                                                    size.height,
                                                                width: 26,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    begin: Alignment
                                                                        .centerRight,
                                                                    end:
                                                                        Alignment(
                                                                      0.01,
                                                                      0.0,
                                                                    ),
                                                                    colors: [
                                                                      Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.1),
                                                                      Colors
                                                                          .black,
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : SizedBox.shrink(),
                                                ),
                                          Indexed(
                                            index: 3,
                                            child: widget.top10
                                                ? Positioned(
                                                    bottom: -10.0,
                                                    left: -16.0,
                                                    child: Stack(
                                                      children: [
                                                        Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 110,
                                                            letterSpacing:
                                                                -20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            foreground: Paint()
                                                              ..style =
                                                                  PaintingStyle
                                                                      .stroke
                                                              ..strokeWidth = 4
                                                              ..color = Colors
                                                                  .grey
                                                                  .shade400,
                                                          ),
                                                        ),
                                                        Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 110,
                                                            letterSpacing:
                                                                -20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFF171717),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                              .values
                              .toList(),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFFE0000),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
