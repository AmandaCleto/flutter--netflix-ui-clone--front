import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

import '../../../../data/carrouselData.dart';
import '../../../../data/detailedData.dart';
import '../../../../data/creditData.dart';

import '../../../../utils/apiUrl.dart';

import '../../components/bottomSheet.dart';

class SimilarRecommendations extends StatefulWidget {
  final String imgPath;
  final String apiSubject;
  final int remove;
  final bool top10;

  const SimilarRecommendations({
    Key? key,
    required this.imgPath,
    required this.apiSubject,
    this.top10: false,
    this.remove: 0,
  }) : super(key: key);

  @override
  _SimilarRecommendationsState createState() => _SimilarRecommendationsState();
}

class _SimilarRecommendationsState extends State<SimilarRecommendations> {
  late String imgPath = '';
  late String detailedApi = '';
  late String creditApi = '';

  //Futures
  late Future<ApiCarrouselData> futureSubject;
  late ApiDetailedData detailedData;
  late ApiCreditData creditData;

  @override
  void initState() {
    super.initState();
    imgPath = widget.imgPath;

    futureSubject =
        carrouselDataFetch(widget.apiSubject, widget.remove).then((value) {
      return value;
    });
  }

  openModalBottomSheet(context, {required itemId, required indexTop10}) async {
    detailedApi = apiDeepUrl(id: itemId, type: 'detailed');
    creditApi = apiDeepUrl(id: itemId, type: 'cast');

    detailedData = await detailedDataFetch(detailedApi);
    creditData = await creditDataFetch(creditApi);

    modalBottomSheet(
      context,
      imgPath: imgPath,
      itemDetailed: detailedData,
      itemCast: creditData,
      indexTop10: indexTop10,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Opcões Semelhantes'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
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
                return Center(
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 4,
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
                                  indexTop10: -1,
                                );
                              },
                              child: Container(
                                width: 122,
                                height: 172,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      '$imgPath${item['poster_path']}',
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          );
                        })
                        .values
                        .toList(),
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
    );
  }
}
