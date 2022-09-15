import 'package:flutter/material.dart';
import 'package:whistle_feed/listeners/myadshow_listener.dart';
import 'package:whistle_feed/whistle_feed.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyappState createState() => MyappState();
}

class MyappState extends State<MyApp> {
  /// you can use your event listeners for adds
  MyAdShowListener adShowListener = MyAdShowListener();


  @override
  Widget build(BuildContext context) {
    // This widget is the root of your application.
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              child: WhistleFeed(
                /// Calling whistlefeed widget inside any column row or container
                ///
                /// Passing pencil size and publisher token
                /// publisher token must be valid get it from the publisher website mentioned in README file.
                pencilsize: 1,

                /// number of Ad cubes
                publishertoken: '116378385233oOAaL_3166',

                /// add your publisher  token here
                adShowListener: adShowListener,

                /// passing the listeners
              ), /////live////
            )
          ],
        ),
      ),
    );
  }
}
