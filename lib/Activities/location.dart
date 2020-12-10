import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:worldclockproject/Activities/worldTime.dart';

class Loader extends StatelessWidget {

  final int load;
  Loader({this.load});

  @override
  Widget build(BuildContext context) {
    return (load == 1) ?
    SpinKitCircle(
      color: Colors.blue,
      size: 60.0,
    ) :
        Text("");
  }
}

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

  int load = 0;
  String err = "";

   void getData(Map data) async{
    WorldTime wt = WorldTime(location: data["location"], flag: data["flag"], url: data["url"]);
    String time = await wt.getTime();

    if(time == "Sorry something went Wrong") {
      setState(() {
        err = "Something went Wrong..Try Again";
        load = 0;
      });
    }
    else{
      Navigator.pushReplacementNamed(context, "/home",arguments: {
        "location": wt.location,
        "flag": wt.flag,
        "time": time,
        "isDay": wt.isDay,
        "url" : wt.url
      });
    }
  }

  List<WorldTime> loc = [
    WorldTime(location: "Berlin", flag: "greece.png", url: "Europe/Berlin"),
    WorldTime(location: "Baghdad", flag: "iraq.png", url: "Asia/Baghdad"),
    WorldTime(location: "Bangkok", flag: "thailand.png", url: "Asia/Bangkok"),
    WorldTime(location: "Chicago", flag: "usa.png", url: "America/Chicago"),
    WorldTime(location: "Cairo", flag: "egypt.png", url: "Africa/Cairo"),
    WorldTime(location: "Dubai", flag: "uae.png", url: "Asia/Dubai"),
    WorldTime(location: "Jakarta", flag: "indonesia.png", url: "Asia/Jakarta"),
    WorldTime(location: "Kolkata", flag: "india.png", url: "Asia/Kolkata"),
    WorldTime(location: "Karachi", flag: "pak.png", url: "Asia/Karachi"),
    WorldTime(location: "Kathmandu", flag: "nepal.png", url: "Asia/Kathmandu"),
    WorldTime(location: "London", flag: "uk.png", url: "Europe/London"),
    WorldTime(location: "Nairobi", flag: "kenya.png", url: "Africa/Nairobi"),
    WorldTime(location: "Seoul", flag: "southkorea.png", url: "Asia/Seoul"),
    WorldTime(location: "Tehran", flag: "iran.png", url: "Asia/Tehran"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Location"),
        centerTitle: true,
      ),
      body: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  children: <Widget>[
                    Text(err,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        )),

                    SizedBox(height: 5.0),

                    Expanded(
                      child: ListView.builder(
                          itemCount: loc.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/${loc[index].flag}"),
                                ),
                                onTap: () {
                                  getData({
                                    "location": loc[index].location,
                                    "flag": loc[index].flag,
                                    "url": loc[index].url});
                                  setState(() {
                                    load = 1;
                                  });
                                },
                                title: Text(loc[index].location,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                            );
                          }),
                    ),
                  ],
                )
            ),
            Center(
              child: Loader(load: load),
            ),
          ]
      ),
    );
  }
}
