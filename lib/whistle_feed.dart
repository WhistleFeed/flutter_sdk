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
  final String?
      publishertoken; //publisher token variable set the token which provided through publisher website
  final int?
      pencilsize; //select desired no of pencils to show minimum is 1 and maximum is 4
  final MyAdShowListener? adShowListener; // listeners for adds

  WhistleFeed({this.publishertoken, this.pencilsize, this.adShowListener});

  _WhistleFeedState createState() => _WhistleFeedState(
      this.publishertoken,
      this.pencilsize,
      this.adShowListener); //passing the paramerters to child class
}

class _WhistleFeedState extends State<WhistleFeed> {
  String? ptoken = ""; //publisher token
  int? pensize; // pencil size
  String pkgname = ""; //package name
  MyAdShowListener? adShowListener; // listeners for Adds
  _WhistleFeedState(this.ptoken, this.pensize, this.adShowListener);
  bool shrinkadds = true; // boolean value to shrink adds
  late WhistleFeedModel whistleFeedModel; //data of objects of adds list

  @override
  void initState() {
    setState(() {
      getPackage(); //Api calling
    });
    super.initState();
  }

  Future<void> getadds(
      String? pubtoken, int? size, String platform, String packagename) async {
    // api headers
    var headers = {
      'Content-Type': 'text/plain',
      'Cookie': 'ci_session=ept5brqr1v9smenbgkptqu19vkggme9m'
    };
    //api request
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
      //json decode
      final item = json.decode(response.body);
      print(item);

      whistleFeedModel = WhistleFeedModel.fromJson(item);

      print(whistleFeedModel.message);
      if (whistleFeedModel.message == "verified") {
        // everything is verifird
        print('verified');
        if (whistleFeedModel.data!.campgainlist!.isEmpty) {
          shrinkadds = true; //shrinking adds if no adds are there.
          adShowListener!.onAdShowFailure('No Adds are There');
        } else {
          shrinkadds = false;
          adShowListener!.onAdShowStart('Adds Are Showing'); //lister to
        }
      } else {
        if (whistleFeedModel.message == 'user not found') {
          adShowListener!.onAdShowFailure('Add your Publisher Token');
          shrinkadds = true;
          print('Add your Publisher Token');
        }
      }
    } else {
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
      if (Platform
          .isAndroid) // if platform calling the whistle feed sdk is based on android will need to pass Android as platform value
      {
        getadds(ptoken, pensize, 'Android', pkgname);
      } else {
        getadds(ptoken, pensize, 'IOS',
            pkgname); //if platform calling the whistle feed sdk is based on Iphone will need to pass IOS as platform value
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return pkgname == ""
        ? //check package name is empty or not
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
             </body> </html>"""), //script tags for load the  adds
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
                launchUrl(url!,
                    mode: LaunchMode
                        .externalApplication); // navigation of particular Ads When click happens on cubes
                return NavigationActionPolicy.CANCEL;
              },
              onLoadError: (controller, url, code, message) {
                print(message); //load error
              },
              onLoadHttpError: (controller, url, statusCode, description) {
                print(statusCode); //load http error
              },
            ),
          );
  }
}
