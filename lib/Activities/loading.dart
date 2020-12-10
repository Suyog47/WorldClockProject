import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:worldclockproject/Activities/worldTime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loader extends StatelessWidget {

  final int vis;
  Loader({this.vis});

  @override
  Widget build(BuildContext context) {
    if(vis == 1) {
      return Column(
        children: <Widget>[
            SpinKitHourGlass(
              color: Colors.white,
              size: 50.0,
            ),
        ],
      );
    }
      else{
        return Text("Sorry something went Wrong",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0
          ),);
    }
    }
  }

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  int vis = 1;
  String res;

  void getData() async{
    WorldTime wt = WorldTime(location: "India", flag:"india.png", url: "Asia/Kolkata");
    String time = await wt.getTime();

    if(time == "Sorry something went Wrong") {
      setState(() {
        vis = 0;
      });
    }
    else{
      Navigator.pushReplacementNamed(context, "/home",arguments: {
        "location": wt.location,
        "flag": wt.flag,
        "time": time,
        "isDay": wt.isDay,
        "url": "Asia/Kolkata"
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black87,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
            child: Center(
              child: Column(
                children: <Widget>[
                  (vis == 1) ? Loader(vis: 1) : Loader(vis: 0),
                ],
              ),
            ),
          ),
        ),
        );
  }
}