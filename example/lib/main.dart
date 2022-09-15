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
  MyAdShowListener adShowListener = MyAdShowListener();

  /// you can use your event listeners for adds

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              child: WhistleFeed(
                // Calling whistlefeed widget inside any column row or container
                // Passing pencil size and publisher token
                // publisher token must be valid get it from the publisher website mentioned in README file.
                pencilsize: 1,

                /// number of Ad cubes
                publishertoken: 'YOUR_PUBLISHER_TOKEN',

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
