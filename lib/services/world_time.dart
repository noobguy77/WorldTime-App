import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime {
  String location;
  String time;
  String url;
  String flag;
  bool isDaytime;


  WorldTime({this.location, this.flag, this.url});

  Future <void> getTime() async {

    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offsetHour = data['utc_offset'].substring(1,3);
      String offsetMinutes = data['utc_offset'].substring(4,6);
      //print(datetime);
      //print(offset);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHour),minutes: int.parse(offsetMinutes)));

      isDaytime = now.hour > 4 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch (e) {
      print('caught error $e');
      time = "Could not get data for the required Location";
    }

  }
}


