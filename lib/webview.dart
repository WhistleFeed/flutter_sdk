import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class MyWebViewForWhistlefeed extends StatefulWidget {
  @override
  _MyWebViewForBuddyClubState createState() => _MyWebViewForBuddyClubState();
  static String routeName = "/myWebViewforbuddyloan";
}

class _MyWebViewForBuddyClubState extends State<MyWebViewForWhistlefeed> {
  bool isPageLoading = true;
  bool isToShowBackButton=false;

  int progressBar = 0;
  String rootUrl="";

  bool delayToAvoidGlitch = true;
  bool pacmanResult = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 200), () {
      setState(() {
        delayToAvoidGlitch = false;
        rootUrl = ModalRoute
            .of(context)
            .settings
            .arguments;
      }

      );

    }
    );
  }
  @override
  void dispose() {
    super.dispose();
  }

  InAppWebViewController webView;



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    print("my webview url is $rootUrl $isToShowBackButton");

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
            leading: !isToShowBackButton?Container():IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: Container(
              padding: EdgeInsets.only(right: 40),
              child: Center(
                child: Text('Whistle Feed')
              ),
            )
        ),
      ),

      body: delayToAvoidGlitch ? Container() : InAppWebView(
        initialUrl: "https://hooks.feed.whistle.mobi/d?alias=132&token=116378385233oOAaL_4&auth_url=https://www.buddyloan.com/blog/a-detailed-guide-to-get-a-good-credit-score/",
        initialHeaders: {},
        onLoadError: (controller,url,code,msg)async{

          if(url.contains("https://hooks.feed.whistle.mobi/d?alias=132&token=116378385233oOAaL_4&auth_url=https://www.buddyloan.com/blog/a-detailed-guide-to-get-a-good-credit-score/")) {
            return;
          }
          if(Platform.isIOS)
          {
            print("root url is for launch in browser $rootUrl");
          }

          print("launch url error");

        },
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              debuggingEnabled: false, useOnDownloadStart: true),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onLoadStart: (InAppWebViewController controller, String url) async {
          print("on load start $url");
          if(url.contains("https://buddyjob.in/deep_link")
              ||url.contains("https://buddyloan.in/deep_link")
              ||url.contains("https://buddyloan.com/deep_link"))
          {
            final Uri uri=Uri.dataFromString(url);
            Map<String, String> params = uri.queryParameters;
            String routeName=params['sctl']!=null?params['sctl']:"";
            if(routeName.isNotEmpty)
            {
              print("route name is $routeName");

            }
          }
          if (url.contains("market://details")) {
            print("url contains market field ");
          }

          if (url.contains("pacmangame")) {
            return;

          }

          isPageLoading = true;
        },
        onLoadStop: (InAppWebViewController controller, String url) async {
          print("on load stop $url");
          isPageLoading = false;
        },
        onDownloadStart: (controller, url) async {

        },
      ),
    );

  }


}