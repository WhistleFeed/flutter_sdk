import 'package:flutter/material.dart';
import 'package:whistle_feed/listeners/MyAdShowListener.dart';
import 'package:whistle_feed/WhistleFeed.dart';
void main() {runApp(MyApp());}
class MyApp extends StatefulWidget{

  _myappstate createState()=> _myappstate();

}
class _myappstate extends State<MyApp>{

  MyAdShowListener adShowListener = MyAdShowListener(); // you can use your event listeners for adds

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(
        body: Column(
          children: [
            SizedBox(height: 100,),
            Container(
              child:
              WhistleFeed(
                pencilsize: 1, // number of Ad cubes
                publishertoken: 'YOUR_PUBLISHER_TOKEM',// add your publisher  token here
                adShowListener: adShowListener, // passing the listeners
              ), /////live////
            )
          ],
        ),
      ),
    );
  }
}

