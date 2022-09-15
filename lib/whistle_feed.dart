import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'listeners/myadshow_listener.dart';
import 'model/whistle_feedmodel.dart';

class WhistleFeed extends StatefulWidget {
  ///publisher token variable set the token which provided through publisher website
  final String? publishertoken;

  ///select desired no of pencils to show minimum is 1 and maximum is 4
  final int? pencilsize;

  /// listeners for adds
  final MyAdShowListener? adShowListener;

  WhistleFeed({this.publishertoken, this.pencilsize, this.adShowListener});

  _WhistleFeedState createState() => _WhistleFeedState(
      //passing the paramerters like publihsertoken pencilsize to child class
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
  bool shrinkadds = true;

  ///data of objects of adds list
  late WhistleFeedModel whistleFeedModel;

  @override
  void initState() {
    setState(() {
      ///Api calling
      getPackage();
    });
    super.initState();
  }

  Future<void> getadds(
      String? pubtoken, int? size, String platform, String packagename) async {
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
        '''{"os_name":"$platform","publisher_token":"$pubtoken","api_called":1,"size":$size,"parentUrl":"$pkgname"}''';
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
        print('verified');

        if (whistleFeedModel.data!.campgainlist!.isEmpty) {
          // if no adds were there

          ///shrinking adds if no adds are there.
          shrinkadds = true;
          adShowListener!.onAdShowFailure('No Adds are There');
        } else {
          /// adds are there
          shrinkadds = false;
          adShowListener!.onAdShowStart('Adds Are Showing'); //lister to
        }
      } else {
        if (whistleFeedModel.message == 'user not found') {
          // if wrong publisher token or empty publisher token
          adShowListener!.onAdShowFailure('Add your Publisher Token');
          shrinkadds = true;
          print('Add your Publisher Token');
        }
      }
    } else {
      // errors
      print(streamedResponse.reasonPhrase);
    }
  }

  void getPackage() async {
    //since sdk relies on the package name to work correctly so thereby using packageinfo package
    //to fetch the package name of the app using the feeds sdk
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageInfo = await PackageInfo.fromPlatform();
    pkgname = packageInfo.packageName;
    print('printpackagename$pkgname');

    setState(() {
      //platform checking is android or ios
      if (Platform.isAndroid) {
        // if platform calling the whistle feed sdk is based on android will need to pass Android as platform value
        getadds(ptoken, pensize, 'Android', pkgname);
      } else {
        //if platform calling the whistle feed sdk is based on Iphone will need to pass IOS as platform value
        getadds(ptoken, pensize, 'IOS', pkgname);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return pkgname == ""
        ?

        ///check package name is empty or not
        Container()
        : Container(
            height: pensize == 1
                ? 125
                : pensize == 2
                    ? 230
                    : pensize == 3
                        ? 330
                        : pensize == 4
                            ? 430
                            : 0,
            child: InAppWebView(
              initialData: InAppWebViewInitialData(
                  data: """<!DOCTYPE html> <html lang="en"> <body> 
            <script src="https://pixel.whistle.mobi/feedAds.js" size="$pensize" token="$ptoken" packagename="$pkgname"></script>
             </body> </html>"""),

              ///script tags for load the  adds
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
                print("on web created");
              },
              shouldOverrideUrlLoading: (controller, request) async {
                var url = request.request.url;
                launchUrl(url!, mode: LaunchMode.externalApplication);

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
            ),
          );
  }
}
