import 'package:flutter/material.dart';
import 'package:whistle_feed/whistlefeed_provider.dart';
import 'whistlefeed.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';


void main() {
  runApp( Adds());
}

class Adds extends StatefulWidget {
  _myappstate createState()=> _myappstate();
}
class _myappstate extends State<Adds>
{

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> Whistle_Provider(),
      child: Whistle_feed(),

    );
  }

}

