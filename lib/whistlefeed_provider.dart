import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:whistle_feed/whistle_feed_model.dart';
class Whistle_Provider extends ChangeNotifier {
  List<Campaindata> _campagainlist = [];

  WhistleFeedModel whistleFeedModel;
  List<Data> data;
  List<List<Campaindata>>campaignList = [];

  List<Campaindata> firstpencillist;
  List<Campaindata> seconfpencil;
  List<Campaindata> thirdpencil;
  List<Campaindata> fourthpencil;

  String publisher_token_api="";


  Future<WhistleFeedModel> get_whistle_Feed_Adds(String publisher_token, int size,String platform) async {
    publisher_token_api=publisher_token;
    var headers = {
      'Content-Type': 'text/plain',
      'Cookie': 'ci_session=ept5brqr1v9smenbgkptqu19vkggme9m'
    };
    var request = http.Request('POST',
        Uri.parse(
            'https://feed-api.whistle.mobi/Display_ads_api/displayAdsApi'));
    request.body =
    '''{"os_name":"${platform}","publisher_token":"$publisher_token","api_called":1,"size":$size,"parentUrl":"https://www.buddyloan.com/"}''';
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (streamedResponse.statusCode == 200) {
      final item = json.decode(response.body);
      print(item);

      whistleFeedModel = WhistleFeedModel.fromJson(item);
      print(whistleFeedModel.data.campgainlist.length);

      _campagainlist = whistleFeedModel.data.campgainlist;
      print(_campagainlist.length);

      firstpencillist= List();
      seconfpencil= List();
      thirdpencil=List();
      fourthpencil=List();

      int firstHalf=(_campagainlist.length/size).toInt();
      int secondHalf=_campagainlist.length-firstHalf;
      int thirdHalf= (_campagainlist.length/size).toInt();
      int divided = firstHalf-secondHalf;
   if(size==2)
  {
    firstpencillist.addAll(_campagainlist.sublist(0,firstHalf));
    seconfpencil.addAll(_campagainlist.sublist(firstHalf,_campagainlist.length));
  }

     else if(size==3)
        {
          secondHalf=_campagainlist.length-firstHalf;
          firstpencillist.addAll(_campagainlist.sublist(0,firstHalf));
          seconfpencil.addAll(_campagainlist.sublist(firstHalf,(secondHalf)));
          thirdpencil.addAll(_campagainlist.sublist(secondHalf,_campagainlist.length));
          int chunks=(_campagainlist.length/size).toInt();
          int howManyExtraHave=_campagainlist.length-(3*chunks);
          print("extrra ${howManyExtraHave}");


        }
     else if(size==4) {
      secondHalf=firstHalf+firstHalf;
      thirdHalf=secondHalf+firstHalf;
     int fourthHalf=thirdHalf+firstHalf;
      int chunks=(_campagainlist.length/size).toInt();
      int howManyExtra=_campagainlist.length-(4*chunks);
      print("print remaining ${howManyExtra}");

      firstpencillist.addAll(_campagainlist.sublist(0,firstHalf));
      seconfpencil.addAll(_campagainlist.sublist(firstHalf,secondHalf));
      thirdpencil.addAll(_campagainlist.sublist(secondHalf,thirdHalf));
      fourthpencil.addAll(_campagainlist.sublist(thirdHalf,fourthHalf));

      if(howManyExtra>0)
        {
          if(howManyExtra==1)
            {
              fourthpencil.addAll(_campagainlist.sublist(fourthHalf,fourthHalf+1));
            }
          else  if(howManyExtra==2)
          {
            thirdpencil.addAll(_campagainlist.sublist(fourthHalf,fourthHalf+1));
            fourthpencil.addAll(_campagainlist.sublist(fourthHalf,fourthHalf+2));
          }
          else  if(howManyExtra==3)
          {
            seconfpencil.addAll(_campagainlist.sublist(fourthHalf,fourthHalf+1));
            thirdpencil.addAll(_campagainlist.sublist(fourthHalf,fourthHalf+2));
            fourthpencil.addAll(_campagainlist.sublist(fourthHalf,fourthHalf+3));
          }
        }









   }


    }
    else {
      print(streamedResponse.reasonPhrase);
    }

    notifyListeners();
  }




}

/*     if(size==2)
      {
        if(_campagainlist.length % size == 0)
        {
          print(_campagainlist.length.toString() + " is even number.");

          print("printcampgainlist"+(_campagainlist.length/size).toInt().toString());


          firstpencillist = _campagainlist.sublist(0,4);
          seconfpencil = _campagainlist.sublist(4,8);

          campaignList.add(firstpencillist);

          campaignList.add(seconfpencil);

          print("printcampgainlist"+(firstpencillist.length).toString());

          for(int j=0;j<seconfpencil.length;j++)
          {

            print("seconfpencil"+seconfpencil[j].headline);

          }
          for(int i=0;i<firstpencillist.length;i++)
            {
              print("firstpencil"+firstpencillist[i].headline);

            }

        }
        else
        {
          firstpencillist=_campagainlist.sublist(0,(_campagainlist.length/size-1).toInt());
          campaignList.add(firstpencillist.reversed);

          seconfpencil=_campagainlist.sublist((_campagainlist.length/size+1).toInt(),(_campagainlist.length/size-1).toInt());
          campaignList.add(seconfpencil);



        }
      }
      else if(size==3)
      {
        print("size is true");
        if(_campagainlist.length % size == 0)
        {

          firstpencillist = _campagainlist.sublist(0,4);
          seconfpencil = _campagainlist.sublist(4,8);
          thirdpencil = _campagainlist.sublist(8,12);

          campaignList.add(firstpencillist);
          campaignList.add(seconfpencil);
          campaignList.add(thirdpencil);


          print("printcampgainlist"+(firstpencillist.length).toString());

          for(int j=0;j<seconfpencil.length;j++)
          {

            print("seconfpencil"+seconfpencil[j].headline);

          }
          for(int i=0;i<firstpencillist.length;i++)
          {
            print("firstpencil"+firstpencillist[i].headline);

          }
          for(int i=0;i<thirdpencil.length;i++)
          {
            print("thirdpencil"+thirdpencil[i].headline);

          }

        }
        else
        {
          firstpencillist=_campagainlist.sublist(0,(_campagainlist.length/size-1).toInt());
          campaignList.add(firstpencillist.reversed);

          seconfpencil=_campagainlist.sublist((_campagainlist.length/size+1).toInt(),(_campagainlist.length/size-1).toInt());
          campaignList.add(seconfpencil);

          thirdpencil=_campagainlist.sublist((_campagainlist.length/size+1).toInt(),(_campagainlist.length/size-1).toInt());
          campaignList.add(thirdpencil);



        }


      }
      else if(size==4)
      {

        print("even loop is coming here");
        print(_campagainlist.length % size==0);

        if(_campagainlist.length % size == 0)
        {
          print(_campagainlist.length.toString() + " is even number.");

          print("printcampgainlist"+(_campagainlist.length/size).toInt().toString());


          firstpencillist = _campagainlist.sublist(0,4);
          seconfpencil = _campagainlist.sublist(4,8);
          thirdpencil = _campagainlist.sublist(8,12);
          fourthpencil = _campagainlist.sublist(12,16);

          campaignList.add(firstpencillist);
          campaignList.add(seconfpencil);
          campaignList.add(thirdpencil);
          campaignList.add(fourthpencil);


          print("printcampgainlist"+(firstpencillist.length).toString());

          for(int j=0;j<seconfpencil.length;j++)
          {

            print("seconfpencil"+seconfpencil[j].headline);

          }
          for(int i=0;i<firstpencillist.length;i++)
          {
            print("firstpencil"+firstpencillist[i].headline);

          }
          for(int i=0;i<thirdpencil.length;i++)
          {
            print("thirdpencil"+thirdpencil[i].headline);

          }
          for(int i=0;i<fourthpencil.length;i++)
          {
            print("fourthpenci"+fourthpencil[i].headline);

          }

        }
        else
        {
          print("check odd");
          firstpencillist=_campagainlist.sublist(0,(_campagainlist.length).toInt());
          campaignList.add(seconfpencil);

          print(_campagainlist.length/size);

          for(int i=0;i<firstpencillist.length;i++)
            {
              print("firstpencil"+firstpencillist[i].brandname);

            }

          seconfpencil=_campagainlist.sublist((_campagainlist.length/size).toInt(),(_campagainlist.length/size).toInt());
          campaignList.add(seconfpencil);


          for(int i=0;i<seconfpencil.length;i++)
          {
            print("secondpencil"+seconfpencil[i].brandname);

          }

          thirdpencil=_campagainlist.sublist(12,(_campagainlist.length/size-1).toInt());
          campaignList.add(thirdpencil);

          fourthpencil=_campagainlist.sublist(12,(_campagainlist.length/4).toInt());
          campaignList.add(fourthpencil.reversed);



          for(int i=0;i<firstpencillist.length;i++)
            {
              print("firstpencildata when ads is odd"+firstpencillist[i].brandname);
            }
          for(int i=0;i<seconfpencil.length;i++)
            {
              print("firstpencildata when ads is odd"+seconfpencil[i].brandname);
            }

          for(int i=0;i<thirdpencil.length;i++)
            {


            }



       *//*   firstpencillist = _campagainlist.sublist(0,_campagainlist.length -1);
          firstpencillist.addAll(_campagainlist.sublist(_campagainlist.length-1,_campagainlist.length));
          campaignList.add(firstpencillist);

          seconfpencil = _campagainlist.sublist(firstpencillist.length-1,_campagainlist.length -1);
          seconfpencil.addAll(_campagainlist.sublist(_campagainlist.length-1,_campagainlist.length));
          campaignList.add(seconfpencil);


          thirdpencil = _campagainlist.sublist(seconfpencil.length,_campagainlist.length -1);
          thirdpencil.addAll(_campagainlist.sublist(_campagainlist.length-1,_campagainlist.length));
          campaignList.add(thirdpencil);

          fourthpencil = _campagainlist.sublist(thirdpencil.length,_campagainlist.length -1);
          fourthpencil.addAll(_campagainlist.sublist(_campagainlist.length-1,_campagainlist.length));
          campaignList.add(fourthpencil);
*//*



        }
      }
      else
      {
        if(_campagainlist.length % size == 0)
        {
          print(_campagainlist.length.toString() + " is even number.");

          print("printcampgainlist"+(_campagainlist.length/size).toInt().toString());


          firstpencillist = _campagainlist.sublist(0,4);

          campaignList.add(firstpencillist);

          print("printcampgainlist"+(firstpencillist.length).toString());


          for(int i=0;i<firstpencillist.length;i++)
          {
            print("firstpencil"+firstpencillist[i].headline);

          }

        }
        else
        {



        }
      }
*/