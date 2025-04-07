





int intakes({required List<DateTime> dateList}){

  final now = DateTime.now();

  List<DateTime> futureDates = dateList.where((dateTime) => dateTime.isAfter(now)).toList();

  return (dateList.length - futureDates.length);

}