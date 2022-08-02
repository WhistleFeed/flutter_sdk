import 'package:flutter/material.dart';
import 'package:whistle_feed/listeners/MyAdShowListener.dart';
import 'package:whistle_feed/whistle_adds.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

  _myappstate createState()=> _myappstate();

}
class _myappstate extends State<MyApp>{

  MyAdShowListener adShowListener = MyAdShowListener();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(
        body: Column(
          children: [
            SizedBox(height: 100,),
            Container(
              color:Colors.black,
              child:
              Whistle_adds(
                pencil_size: 1,
                publisher_token: '116378385233oOAaL_3052',
                adShowListener: adShowListener,
                packagename: 'com.buddyloan.vls',
              )
              , /////live////
            )
          ],
        ),
      ),
    );
  }
}

