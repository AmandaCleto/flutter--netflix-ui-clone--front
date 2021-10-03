import 'package:flutter/material.dart';

import '../../../../data/carrouselData.dart';
import '../../../../data/detailedData.dart';
import '../../../../data/creditData.dart';

import '../../../../config/config.dart';

import '../../../../utils/apiUrl.dart';

import '../../components/bottomSheet.dart';

class SimilarRecommendations extends StatefulWidget {
  final String apiSubject;
  final int remove;
  final bool top10;

  const SimilarRecommendations({
    Key? key,
    required this.apiSubject,
    this.top10: false,
    this.remove: 0,
  }) : super(key: key);

  @override
  _SimilarRecommendationsState createState() => _SimilarRecommendationsState();
}

class _SimilarRecommendationsState extends State<SimilarRecommendations> {
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
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Divider(
                color: Colors.white,
                height: 0,
              ),
              Container(
                width: 200,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0xFFFE0000),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Opcões Semelhantes'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
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
                    runSpacing: 6,
                    spacing: 4,
                    children: snapshot.data!.results
                        .asMap()
                        .map((index, item) {
                          return MapEntry(
                            index,
                            GestureDetector(
                              onTap: () {
                                print((item['poster_path'] != null &&
                                        item['poster_path'] != '')
                                    ? 'oi'
                                    : 'xau');
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
                                    image: ((item['poster_path'] != null &&
                                            item['poster_path'] != ''))
                                        ? NetworkImage(
                                            '$IMAGE_PATH${item['poster_path']}',
                                          )
                                        : AssetImage('assets/default-movie.png')
                                            as ImageProvider,
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
