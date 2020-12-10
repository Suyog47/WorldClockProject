import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String flag;
  String url;
  bool isDay;

  WorldTime({this.location,this.flag,this.url});

  Future<String> getTime() async {
    try {
      Response res = await get("http://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(res.body);

      String time = data["datetime"];
      String offsetHR = data["utc_offset"].substring(0, 3);
      String offsetMIN = data["utc_offset"].substring(4,);

      DateTime dt = DateTime.parse(time);
      dt = dt.add(Duration(hours: int.parse(offsetHR), minutes: int.parse(offsetMIN)));

      isDay = dt.hour > 6 && dt.hour < 18 ? true : false;

       return DateFormat.jm().format(dt);
    }
    catch(e){
      return "Sorry something went Wrong";
    }
  }
}