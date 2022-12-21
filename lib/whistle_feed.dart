import 'dart:async';
import 'dart:convert';
import 'package:advertising_id/advertising_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:visibility_detector/visibility_detector.dart';
import 'listeners/myadshow_listener.dart';
import 'model/whistle_feedmodel.dart';

class WhistleFeed extends StatefulWidget {
  ///publisher token variable set the token which provided through publisher website
  final String? publishertoken;

  ///select desired no of pencils to show minimum is 1 and maximum is 4
  final int? pencilsize;

  /// listeners for adds
  final MyAdShowListener? adShowListener;



  WhistleFeed({this.publishertoken,this.pencilsize,this.adShowListener});

  _WhistleFeedState createState() => _WhistleFeedState(

      ///passing the paramerters like publihsertoken pencilsize to child class
      this.publishertoken,
      this.pencilsize,
      this.adShowListener);
}

class _WhistleFeedState extends State<WhistleFeed> {
  ///publisher token
  String? ptoken = "";

  /// pencil size
  int? pensize;

  ///package name
  String pkgname = "";

  /// listeners for Adds
  MyAdShowListener? adShowListener;

  ///accessing the parameters from parent class
  _WhistleFeedState(this.ptoken, this.pensize, this.adShowListener);

  /// boolean value to shrink adds
   bool shrinkadds=false;


  ///script tags variable
  var script_tags;

  ///set live or staging link
  bool islink=true;

  ///base url
  String BASE_URL="";

  ///staging url
  String STAGING_LINK="http://13.232.216.75/whistle-pixel/feedAds.php?";

  ///live url
  String LIVE_LINK="https://pixel.whistle.mobi/feedAds.php?";

  ///device id
  String deviceId = "";

  bool iSapiCalled =false;

  int counter=0;

  @override
  void initState() {
    setState(() {
      ///Api calling
      getPackage();
      liveOrStaging();
    });
    super.initState();
  }

  void liveOrStaging()
  {
    if(islink)
      {
        BASE_URL=LIVE_LINK;
      }
    else
      {
        BASE_URL=STAGING_LINK;
      }
  }

  ///method for api calling
/*
  Future<void> getadds(String? pubtoken, int? size, String platform, String packagename) async {
    /// api headers
    var headers = {
      'Content-Type': 'text/plain',
      'Cookie': 'ci_session=ept5brqr1v9smenbgkptqu19vkggme9m'
    };

    ///api request
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://feed-api.whistle.mobi/Display_ads_api/displayAdsApi'));
    request.body =
        '''
        {"os_name":"$platform",
        "publisher_token":"$pubtoken",
        "api_called":1,"size":$size,
        "parentUrl":"$pkgname"}''';
    request.headers.addAll(headers);
    print('print the request${request.body}');
    http.StreamedResponse streamedResponse = await request.send(); // request
    var response = await http.Response.fromStream(streamedResponse); //response

    if (streamedResponse.statusCode == 200) {
      //if response status code is 200

      ///json decode
      final item = json.decode(response.body);
      print(item);

      whistleFeedModel = WhistleFeedModel.fromJson(item);

      print(whistleFeedModel.message);

      if (whistleFeedModel.message == "verified") {
        // if response of messege is verified

        if (whistleFeedModel.data!.campgainlist!.isEmpty) {
          // if no adds were there
          adShowListener!.onAdShowStart('Verified'); //lister to

          ///shrinking adds if no adds are there.

          setState(() {
            /// to shrink widget
            shrinkadds = true;
          });

          ///throwing error messege through listeners if no adds were there
          adShowListener!.onAdShowFailure('No Adds are There');
        } else {
          setState(() {
            /// to unshrink widget
            shrinkadds = false;
          });

          ///throwing messege through listeners if Ads were showing
          adShowListener!.onAdShowComplete('Ads Are Showing'); //lister to
        }
      } else {
        if (whistleFeedModel.message == 'user not found') {
          setState(() {
            /// to shrink widget
            shrinkadds = true;
          });

          /// if wrong publisher token or empty publisher token
          adShowListener!.onAdShowFailure('Add your Publisher Token');
          print('Add your Publisher Token');
        }
      }
    } else {
      // errors
      print(streamedResponse.reasonPhrase);
      setState(() {
        /// to shrink widget
        shrinkadds = true;
      });
    }
  }
*/

  ///method for s2s
  Future<void> getscripttagsfromapi(String? pubtoken, int? size,String packagename) async
  {
    counter=counter+1;
    print('checkcounterafterapicalled${counter}');
    deviceId = (await AdvertisingId.id(true))!;
    print('printtheurl ${BASE_URL}packagename=${packagename}&size=${size}&apiToken=${pubtoken}&add_id=${deviceId}');
    var request = http.Request('GET', Uri.parse('${BASE_URL}packagename=${packagename}&size=${size}&apiToken=${pubtoken}'));

    http.StreamedResponse streamedResponse = await request.send(); // request
    var response = await http.Response.fromStream(streamedResponse); //response

    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      print("printscripttags${item['data']}");

      if(item['status']=='Success')
        {
          setState(() {
            /// to shrink widget
            script_tags=item['data'];
            shrinkadds = false;
            adShowListener!.onAdShowStart(item['message']);
            iSapiCalled=true;
          });
        }
      else
        {
         setState(()
         {
             shrinkadds = true;
             print("failureeee");
             adShowListener!.onAdShowFailure(item['message']);
             iSapiCalled=true;
        });

        }
      print(item);
    }
    else {
      shrinkadds = true;
      print(response.reasonPhrase);
    }
  }

  void getPackage() async {
    ///since sdk relies on the package name to work correctly so thereby using packageinfo package
    ///to fetch the package name of the app using the feeds sdk
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageInfo = await PackageInfo.fromPlatform();
    pkgname = packageInfo.packageName;
    print('printpackagename$pkgname');
    setState(() {
      ///api calling
      //getscripttagsfromapi(ptoken,pensize,pkgname);
/*
      ///platform checking is android or ios
      if (Platform.isAndroid) {
        /// if platform calling the whistle feed sdk is based on android will need to pass Android as platform value
        //getadds(ptoken, pensize, 'Android', pkgname);
        getscripttagsfromapi(ptoken,pensize,pkgname);
      } else {
        ///if platform calling the whistle feed sdk is based on Iphone will need to pass IOS as platform value
       // getadds(ptoken, pensize, 'IOS', pkgname);
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return shrinkadds==true?Container():
    VisibilityDetector(
        key: Key('my-widget-key'),
        child: Container(
          ///setting height of container basis of pencil heights
          height: pensize == 1
              ? 125
              : pensize == 2
              ? 240
              : pensize == 3
              ? 330
              : pensize == 4
              ? 430
              : 0,
          child: iSapiCalled==true?InAppWebView(
            initialData: InAppWebViewInitialData(
              ///script tags for load the  adds
                data: """${script_tags}"""),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useOnDownloadStart: true,
                clearCache: true,
                javaScriptEnabled: true,
                useShouldOverrideUrlLoading: true,
                useOnLoadResource: true,
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              ///web create
              print("on web created");
            },
            shouldOverrideUrlLoading: (controller, request) async {
              var url = request.request.url;
              //  launchUrl(url!, mode: LaunchMode.externalApplication);
              launch(url.toString());

              /// navigation of particular Ads When click happens on cubes
              return NavigationActionPolicy.CANCEL;
            },
            onLoadError: (controller, url, code, message) {
              print(message);
              ///load error
            },
            onLoadHttpError: (controller, url, statusCode, description) {
              print(statusCode);

              ///load http error
            },
          ):Container(),
        ),
        onVisibilityChanged: (visibilityInfo){
          var visiblePercentage = visibilityInfo.visibleFraction * 50;

          debugPrint(
              'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
          if(visiblePercentage!=null&&visiblePercentage==50.0)
          {
            setState(() {

              print("printthecountervalue${counter}");
              if(counter==0)
              {
                getscripttagsfromapi(ptoken,pensize,pkgname);
              }

            });

          }
          else
          {
            print('hdjwgcjxhlkhkhkh');
          }

        });
  }
}
