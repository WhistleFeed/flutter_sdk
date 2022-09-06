import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'listeners/MyAdShowListener.dart';
import 'model/whistle_feed_model.dart';

class Whistle_adds extends StatefulWidget{
  String? publisher_token=""; //publisher token variable set the token which provided through publisher website
  int? pencil_size = 1; //select desired no of pencils to show minimum is 1 and maximum is 4

  MyAdShowListener? adShowListener;

  Whistle_adds({this.publisher_token,this.pencil_size,this.adShowListener});


  _whistle_adds createState()=> _whistle_adds(this.publisher_token,this.pencil_size,this.adShowListener);
}
class _whistle_adds extends State<Whistle_adds>{

  String? ptoken="";
  int? pensize;
  String Packagename="";
  MyAdShowListener? adShowListener;
  _whistle_adds(this.ptoken,this.pensize,this.adShowListener);
  double progress = 0;
  bool shrinkadds=true;
  late WhistleFeedModel whistleFeedModel;

  @override
  void initState() {
    setState(() {

     getPackage();
    });
    super.initState();
  }

  Future<void> get_whistle_Feed_Adds(String? publisher_token, int? size,String platform,String packagename) async {
    var headers = {
      'Content-Type': 'text/plain',
      'Cookie': 'ci_session=ept5brqr1v9smenbgkptqu19vkggme9m'
    };
    var request = http.Request('POST',
        Uri.parse(
            'https://feed-api.whistle.mobi/Display_ads_api/displayAdsApi'));
    request.body =
    '''{"os_name":"${platform}","publisher_token":"$publisher_token","api_called":1,"size":$size,"parentUrl":"$Packagename"}''';
    request.headers.addAll(headers);
    print('print the request${request.body}');
    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (streamedResponse.statusCode == 200) {
      final item = json.decode(response.body);
      print(item);

      whistleFeedModel = WhistleFeedModel.fromJson(item);

      print(whistleFeedModel.message);
      if(whistleFeedModel.message=="verified")
      {
        print('verified');
        if(whistleFeedModel.data!.campgainlist!.isEmpty)
        {
          shrinkadds=true;
          adShowListener!.onAdShowFailure('No Adds are There');

        }
        else
          {
            shrinkadds=false;
            adShowListener!.onAdShowStart('Adds Are Showing');
          }
      }
      else
      {
        if(whistleFeedModel.message=='user not found')
        {
          adShowListener!.onAdShowFailure('Add your Publisher Token');
          shrinkadds=true;
          print('Add your Publisher Token');
        }
      }
    }
    else {
      print(streamedResponse.reasonPhrase);
    }

  }
  void getPackage() async {
    //since sdk relies on the package name to work correctly so thereby using packageinfo package
    //to fetch the package name of the app using the feeds sdk
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageInfo = await PackageInfo.fromPlatform();
    Packagename = packageInfo.packageName;
    print('printpackagename${Packagename}');

    if(Packagename=="" || Packagename==null)
      {
      }
    else
      {
        setState(() {
          if(Platform.isAndroid) // if platform calling the whistle feed sdk is based on android will need to pass Android as platform value
          {
            get_whistle_Feed_Adds(ptoken, pensize,'Android',Packagename);
          }
          else{
            get_whistle_Feed_Adds(ptoken, pensize,'IOS',Packagename);//if platform calling the whistle feed sdk is based on Iphone will need to pass IOS as platform value
          }
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Packagename==""||Packagename==null?Container():Container(
      height: pensize==1?125
          :pensize==2?230
          :pensize==3?330
          :pensize==4?430:0,
      child: InAppWebView(
        initialData: InAppWebViewInitialData(
            data:"""<!DOCTYPE html> <html lang="en"><body style="background:#FAFAFA;"><script src="https://pixel.whistle.mobi/feedAds.js" size="${pensize.toString()}" token="${ptoken}" packagename="${Packagename}"></script></body></html>"""),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useOnDownloadStart: true,
            clearCache: true,
            javaScriptEnabled: true,
            useShouldOverrideUrlLoading: true,
            useOnLoadResource: true,
          ),
        ),
        onProgressChanged: (_, load) {
          setState(() {
            progress = load / 100;
            print(progress.toString()+"print the progress");
          });
        },
        onWebViewCreated: (InAppWebViewController controller) {
          print("on web created");
        },
        shouldOverrideUrlLoading: (controller, request) async {
          var url = request.request.url;
          launch(url.toString());
          return NavigationActionPolicy.CANCEL;
        },

        onLoadError: (controller, url, code, message) {
          print('onloaderror');
          print(code);
          print(message);
        },
        onLoadHttpError: (controller, url, statusCode, description) {
          print("onhttploaderror");
          print(statusCode);
          print(description);
        },
      ),
    );
  }
}