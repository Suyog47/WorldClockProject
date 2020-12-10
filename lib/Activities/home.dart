import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:worldclockproject/Activities/worldTime.dart';


class Loader extends StatelessWidget {

  int load = 2;

  Loader({this.load});

  @override
  Widget build(BuildContext context) {
    if(load == 0){
      return SpinKitCircle(
        color: Colors.grey,
        size: 30.0,
      );
    }
    else if(load == 1){
      return Text("Something went Wrong...Please wait",
                   style: TextStyle(
                     color: Colors.red,
                     fontSize: 15.0,
                   ),);
    }
    else{
      return Text("");
    }
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};
  String time = "", flag = "", loc = "", url = "", err = "", prevT = "";
  bool isday;
  int ld = 2;
  Timer timer;

  void getData() async {
    WorldTime wt = WorldTime(location: loc, flag: flag, url: url);
    time = await wt.getTime();
    if(time == "Sorry something went Wrong"){
        setState(() {
          err = "Something went Wrong...Please wait";
          ld = 1;
          time = prevT;
        });
    }
    else{
      setState(() {
        isday = wt.isDay;
        time = time;
        prevT = time;
        err = "";
        ld = 2;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (timer) {
        setState(() {
          ld = 0;
        });
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {

    if(data.isEmpty){
      data = ModalRoute.of(context).settings.arguments;
      isday = data["isDay"];
      time = data["time"]; prevT = time;
      loc = data["location"];
      flag = data["flag"];
      url = data["url"];
    }


    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
         image: DecorationImage(
             image: AssetImage(isday == true ? "assets/day.jpg" : "assets/night.jpg"),
             fit: BoxFit.fill
         )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 160.0, 0, 0),
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                children: <Widget>[
                   Loader(load: ld),
                   SizedBox(height: 30.0),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       CircleAvatar(
                         backgroundImage: AssetImage("assets/$flag"),
                       ),
                       SizedBox(width: 10.0),
                       Text(loc,
                         style: TextStyle(
                         fontSize: 25.0,
                           fontWeight: FontWeight.bold,
                           color: Colors.blueAccent,
                ),),
                     ],
                   ),

                   SizedBox(height: 20.0),

                   Text(time,
                   style: TextStyle(
                     fontSize: 80.0,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                   ),),
                  SizedBox(height: 10.0),
                  FlatButton.icon(
                    icon: Icon(Icons.edit_location,color: Colors.white,),
                    label: Text("Change Location",
                    style: TextStyle(color: Colors.deepOrangeAccent),),
                    onPressed: () {
                      timer.cancel();
                     Navigator.pushReplacementNamed(context, "/location");
                    },
                  ),
    ],
              )
              )
            ],
          ),
        ),
      )
    );
  }
}
