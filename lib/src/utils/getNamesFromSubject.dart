String getNames({required itemList, required subject}) {
  List allPeople = [];
  List<dynamic> distinctPeopleList = [];
  String finalListOfPeople = '';

  itemList.asMap().forEach((index, value) => {
        if (value['known_for_department'] == subject)
          allPeople += [value["name"]]
      });

  distinctPeopleList = allPeople.toSet().toList();

  if (distinctPeopleList.length == 0) {
    finalListOfPeople += 'Sem informação. ';
  } else {
    distinctPeopleList.asMap().forEach(
          (index, value) => {
            if (index == (distinctPeopleList.length - 1))
              {
                finalListOfPeople += '$value. ',
              }
            else
              {
                if (index < (distinctPeopleList.length - 1))
                  {
                    finalListOfPeople += '$value, ',
                  }
              }
          },
        );
  }

  return finalListOfPeople;
}
