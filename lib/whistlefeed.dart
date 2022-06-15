import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whistle_feed/whistle_feed_model.dart';
import 'package:http/http.dart' as http;
import 'package:whistle_feed/whistlefeed_provider.dart';

class Whistle_feed extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<Whistle_feed> {
  int firstPenciletimer=30;
  int secondpenciltimer=0;
  int thirdpenciltimer=0;
  int fourthpenciltimer=0;

  WhistleFeedModel  whistleFeedModel;

  int rotationtime=3;
  double opacity = 1.0;


  int indexvalue1=0;
  int indexvalue2=0;
  int indexvalue3=0;
  int indexvalue4=0;

  bool firstpencilvisible=true;
  bool secondpencilvisible=true;
  bool thirdpencilvisible=true;
  bool fourthpencilvisible=true;

  int animationMiliseconds=1200;

  //////////cubes attribute /////////
  double squeeze=1.6;
  double diameter=0.5;
  double perspective=0.00025;
  double itemextent=76;

  //////////////////////////////////

  String publisher_token_api="";
  String platform="";


  ///////normal///
/*  double squeeze=1.85;
  double diameter=0.51;
  double perspective=0.00002;
  double itemextent=76;*/



  @override
  void initState() {
    secondpenciltimer =firstPenciletimer+2;
    thirdpenciltimer =firstPenciletimer+4;
    fourthpenciltimer =firstPenciletimer+6;
    startController();

    checkdevice();
    Provider.of<Whistle_Provider>(context, listen: false).get_whistle_Feed_Adds("116378385233oOAaL_4",pencilsize,platform);

    super.initState();
  }

  @override
  void dispose() {
    print("dispose was called");
    _controller.dispose();
    super.dispose();
  }


  void checkdevice()
  {
    if(Platform.isAndroid)
      {
       platform="Android";
      }
    else {
      platform = "IOS";
    }

  }
  
  FixedExtentScrollController _controller = FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _controller1 = FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _controller2 = FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _controller3 = FixedExtentScrollController(initialItem: 0);
   Timer upperSliderTimer;

  void startController() async {
    int totalitems = 4; //total length of items
    int counter = 1;
    if (counter <= totalitems) {
      upperSliderTimer = Timer.periodic(Duration(seconds: firstPenciletimer), (timer) {


        setState(() {
          firstpencilvisible=false;
        });
        Timer(Duration(milliseconds: animationMiliseconds),(){
          setState(() {
            firstpencilvisible=true;
          });
        });
        _controller.animateToItem(counter, duration: Duration(milliseconds: animationMiliseconds), curve: Curves.easeInCubic);

        _controller.addListener(() {

        });

        if(_controller.animateToItem(counter, duration: Duration(milliseconds: animationMiliseconds), curve: Curves.easeInCubic) != null)
        {
          print('one is rotating');
          Timer(Duration(milliseconds: animationMiliseconds),(){
            setState(() {
              secondpencilvisible=false;
            });
          });

          Timer(Duration(milliseconds: 1800),(){

            _controller1.animateToItem(counter, duration: Duration(milliseconds: animationMiliseconds), curve: Curves.easeInCubic);

            setState(() {
              Timer(Duration(milliseconds: animationMiliseconds),(){
                setState(() {
                  secondpencilvisible=true;
                });
              });
            });

            if(_controller1.animateToItem(counter, duration: Duration(milliseconds: animationMiliseconds), curve: Curves.easeInCubic) != null)
              {
                Timer(Duration(milliseconds: animationMiliseconds),(){
                  setState(() {
                    thirdpencilvisible=false;
                  });
                });
                Timer(Duration(milliseconds: 1800),(){


                  _controller2.animateToItem(counter, duration: Duration(milliseconds: animationMiliseconds), curve: Curves.easeInCubic);
                  setState(() {
                    Timer(Duration(milliseconds: animationMiliseconds),(){
                      setState(() {
                        thirdpencilvisible=true;
                      });
                    });
                  });


                  if(_controller2.animateToItem(counter, duration: Duration(milliseconds: animationMiliseconds), curve: Curves.easeInCubic) != null)
                    {

                      Timer(Duration(milliseconds: animationMiliseconds),(){
                        setState(() {
                          fourthpencilvisible=false;
                        });
                      });
                      Timer(Duration(milliseconds: 1800),(){

                        _controller3.animateToItem(counter, duration: Duration(milliseconds: animationMiliseconds), curve: Curves.easeInCubic);
                        setState(() {
                          Timer(Duration(milliseconds: animationMiliseconds),(){
                            setState(() {
                              fourthpencilvisible=true;
                            });
                          });
                        });
                        counter++;

                      });

                    }





                });

              }



          });



        }


      });
    }
  }

  Future get_impressions(String aliasid) async
  {
    var request = http.Request('POST', Uri.parse('https://hooks.feed.whistle.mobi/i?alias=34&token=${publisher_token_api}&flag=0&auth_url=https://www.buddyloan.com/blog/a-detailed-guide-to-get-a-good-credit-score/'));

    print("url--"+"https://hooks.feed.whistle.mobi/i?alias=${aliasid}&token=${publisher_token_api}&flag=0&auth_url=https://www.buddyloan.com/blog/a-detailed-guide-to-get-a-good-credit-score/");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }


  }

  List<Color> firstpencilcolor = [
    Color(0xFFD72631),
    Color(0xFFE75974),
    Color(0xFF26495C),
    Color(0xFFE3B448)
  ];

  List<Color> secondpencilcolor = [
    Color(0xFF077B8A),
    Color(0xFFBE1558),
    Color(0xFFC4A35A),
    Color(0xFF95BB6F),
  ];

  List<Color> thirdpencilcolor = [
    Color(0xFF66A995),
    Color(0xFF8E6C6B),
    Color(0xFFC66B3D),
    Color(0xFF3A6B35)
  ];

  List<Color> fourthpencilcolor = [
    Color(0xFF5C3C92),
    Color(0xFF322514),
    Color(0xFF655B4E),
    Color(0xFF05716C)
  ];


/*  List <Color> globalcolors=[
    Color(0xFFD72631),
    Color(0xFFE75974),
    Color(0xFF26495C),
    Color(0xFFE3B448),
    Color(0xFF077B8A),
    Color(0xFFBE1558),
    Color(0xFFC4A35A),
    Color(0xFF95BB6F),
    Color(0xFF66A995),
    Color(0xFF8E6C6B),
    Color(0xFFC66B3D),
    Color(0xFF3A6B35),
    Color(0xFF5C3C92),
    Color(0xFF322514),
    Color(0xFF655B4E),
    Color(0xFF05716C)

  ];*/

  int pencilsize=4;

  Widget pencils()
  {

    List<Campaindata>firstPencil=Provider.of<Whistle_Provider>(context,listen:true).firstpencillist;
    List<Campaindata>secondPencil=Provider.of<Whistle_Provider>(context,listen:true).seconfpencil;
    List<Campaindata>thirdpencil=Provider.of<Whistle_Provider>(context,listen:true).thirdpencil;
    List<Campaindata>fourthpencil=Provider.of<Whistle_Provider>(context,listen:true).fourthpencil;


    if(pencilsize==1)
      {
        return  Container(
          height: 82,
          child: Column(
            children: [
              Flexible(child: Padding(
                padding:
                EdgeInsets.only(left: 10, right: 5),
                child: GestureDetector(
                  onTap: (){
                    print('fjdsbfjsjdjdsbfj');
                    print("get index of click  ${firstPencil[indexvalue1].brandname}");

                    setState(() {
                      Navigator.pushNamed(context, '/Whistlecta_webview');

                    });

                  },
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: itemextent,
                    controller: _controller,
                    squeeze: squeeze,
                    diameterRatio: diameter,
                    perspective: perspective,
                    physics: NeverScrollableScrollPhysics(),
                    onSelectedItemChanged: (i) {

                      setState(() {
                        print('indexvalue${i}');
                        indexvalue1=i;
                        get_impressions(firstPencil[i].creativeId);

                      });



                    },
                    childDelegate: ListWheelChildLoopingListDelegate(



                      children: List<Widget>.generate(

                        firstPencil.length,

                            (index) => GestureDetector(

                          behavior: HitTestBehavior.translucent,

                          onTap: (){
                            setState(() {
                              print('jijkjndknfjbfk');
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      color: firstpencilcolor[index]
                                  ),
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: InkWell(
                                      onTap: (){
                                        print('clicked');
                                      },
                                      child: Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  child: Flexible(
                                                    child: Wrap(
                                                      crossAxisAlignment: WrapCrossAlignment.center,
                                                      alignment: WrapAlignment.spaceBetween,
                                                      direction: Axis.horizontal,
                                                      children: [
                                                        Text(firstPencil[index].headline,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  behavior: HitTestBehavior.translucent,

                                                  onTap: (){
                                                    setState(() {
                                                      print('clicked');
                                                      Navigator.pushNamed(context, '/Whistlecta_webview');
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black.withOpacity(0.5),
                                                            blurRadius: 2.0,
                                                            spreadRadius: 2.0,
                                                            offset: Offset(-2.2, 3.3)
                                                        ),
                                                      ],

                                                    ),
                                                    child: Center(
                                                      child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                                        child: Text(firstPencil[index].cTA,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                                                      ),
                                                    ),

                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      )



                                  ),
                                ),

                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(padding: const EdgeInsets.only(right: 25),
                                    child: AnimatedOpacity(
                                      opacity: firstpencilvisible ?1 :0,
                                      duration:Duration(seconds: 1),
                                      child: firstpencilvisible==true?Text(firstPencil[index].brandname,):Container(height: 0,),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ));
      }
    else if(pencilsize==2)
    {
      return Container(
        height: 160,
        child: Column(
          children: [
            Flexible(child: Padding(
              padding:
              EdgeInsets.only(left: 10, right: 5),
              child: GestureDetector(
                onTap: (){
                  print('fjdsbfjsjdjdsbfj');
                  print("get index of click  ${firstPencil[indexvalue1].brandname}");

                  setState(() {
                    Navigator.pushNamed(context, '/Whistlecta_webview');

                  });

                },
                child: ListWheelScrollView.useDelegate(
                  itemExtent: itemextent,
                  controller: _controller,
                  squeeze: squeeze,
                  diameterRatio: diameter,
                  perspective: perspective,
                  physics: NeverScrollableScrollPhysics(),
                  onSelectedItemChanged: (i) {

                    setState(() {
                      print('indexvalue${i}');
                      indexvalue1=i;
                      get_impressions(firstPencil[i].creativeId);

                    });



                  },
                  childDelegate: ListWheelChildLoopingListDelegate(



                    children: List<Widget>.generate(

                      firstPencil.length,

                          (index) => GestureDetector(

                        behavior: HitTestBehavior.translucent,

                        onTap: (){
                          setState(() {
                            print('jijkjndknfjbfk');
                          });
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(3)),
                                    color: firstpencilcolor[index]
                                ),
                                width: MediaQuery.of(context).size.width - 60,
                                child: InkWell(
                                    onTap: (){
                                      print('clicked');
                                    },
                                    child: Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                                      child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Flexible(
                                                  child: Wrap(
                                                    crossAxisAlignment: WrapCrossAlignment.center,
                                                    alignment: WrapAlignment.spaceBetween,
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      Text(firstPencil[index].headline,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                behavior: HitTestBehavior.translucent,

                                                onTap: (){
                                                  setState(() {
                                                    print('clicked');
                                                    Navigator.pushNamed(context, '/Whistlecta_webview');
                                                  });
                                                },
                                                child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black.withOpacity(0.5),
                                                          blurRadius: 2.0,
                                                          spreadRadius: 2.0,
                                                          offset: Offset(-2.2, 3.3)
                                                      ),
                                                    ],

                                                  ),
                                                  child: Center(
                                                    child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                                      child: Text(firstPencil[index].cTA,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                                                    ),
                                                  ),

                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    )



                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(padding: const EdgeInsets.only(right: 25),
                                  child: AnimatedOpacity(
                                    opacity: firstpencilvisible ?1 :0,
                                    duration:Duration(seconds: 1),
                                    child: firstpencilvisible==true?Text(firstPencil[index].brandname,):Container(height: 0,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
            SizedBox(height: 10,),
            Flexible(child: Padding(
              padding: const
              EdgeInsets.only(left: 10, right: 5),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    print('checkclickingindex${secondPencil[indexvalue2].brandname}');
                    Navigator.pushNamed(context, '/Whistlecta_webview');

                  });
                },
                child: ListWheelScrollView.useDelegate(
                  itemExtent: itemextent,
                  controller: _controller1,
                  squeeze: squeeze,
                  diameterRatio: diameter,
                  perspective: perspective,
                  onSelectedItemChanged: (i){

                    setState(() {
                      indexvalue2=i;
                      get_impressions(secondPencil[i].creativeId);

                    });
                  },

                  renderChildrenOutsideViewport: false,
                  physics: NeverScrollableScrollPhysics(),
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: List<Widget>.generate(
                      secondPencil.length,
                          (index) => Container(
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(3)),
                                  color: secondpencilcolor[index]
                              ),
                              width: MediaQuery.of(context).size.width - 60,
                              child: Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Flexible(
                                            child: Wrap(
                                              crossAxisAlignment: WrapCrossAlignment.center,
                                              alignment: WrapAlignment.spaceBetween,
                                              direction: Axis.horizontal,
                                              children: [
                                                Text(secondPencil[index].headline,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){},
                                          child:  Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black.withOpacity(0.5),
                                                    blurRadius: 2.0,
                                                    spreadRadius: 2.0,
                                                    offset: Offset(-2.2, 3.3)
                                                ),
                                              ],

                                            ),
                                            child: Center(
                                              child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                                child: Text(secondPencil[index].cTA,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                                              ),
                                            ),

                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ),

                            Align(alignment: Alignment.bottomRight,
                              child: Padding(padding: const EdgeInsets.only(right: 25),
                                child: AnimatedOpacity(
                                  opacity: secondpencilvisible ?1 :0,
                                  duration:Duration(seconds: 1),
                                  child: secondpencilvisible==true?Text(secondPencil[index].brandname,):Container(height: 0,),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      );
    }
    else if(pencilsize==3)
      {
        return Container(
          height: 260,
          child: Column(
            children: [
              Flexible(child: Padding(
                padding:
                EdgeInsets.only(left: 10, right: 5),
                child: GestureDetector(
                  onTap: (){
                    print('fjdsbfjsjdjdsbfj');
                    print("get index of click  ${firstPencil[indexvalue1].brandname}");

                    setState(() {
                      Navigator.pushNamed(context, '/Whistlecta_webview');

                    });

                  },
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: itemextent,
                    controller: _controller,
                    squeeze: squeeze,
                    diameterRatio: diameter,
                    perspective: perspective,
                    physics: NeverScrollableScrollPhysics(),
                    onSelectedItemChanged: (i) {

                      setState(() {
                        print('indexvalue${i}');
                        indexvalue1=i;
                        get_impressions(firstPencil[i].creativeId);


                      });



                    },
                    childDelegate: ListWheelChildLoopingListDelegate(



                      children: List<Widget>.generate(

                        firstPencil.length,

                            (index) => GestureDetector(

                          behavior: HitTestBehavior.translucent,

                          onTap: (){
                            setState(() {
                              print('jijkjndknfjbfk');
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      color: firstpencilcolor[index]
                                  ),
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: InkWell(
                                      onTap: (){
                                        print('clicked');
                                      },
                                      child: Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  child: Flexible(
                                                    child: Wrap(
                                                      crossAxisAlignment: WrapCrossAlignment.center,
                                                      alignment: WrapAlignment.spaceBetween,
                                                      direction: Axis.horizontal,
                                                      children: [
                                                        Text(firstPencil[index].headline,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  behavior: HitTestBehavior.translucent,

                                                  onTap: (){
                                                    setState(() {
                                                      print('clicked');
                                                      Navigator.pushNamed(context, '/Whistlecta_webview');
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black.withOpacity(0.5),
                                                            blurRadius: 2.0,
                                                            spreadRadius: 2.0,
                                                            offset: Offset(-2.2, 3.3)
                                                        ),
                                                      ],

                                                    ),
                                                    child: Center(
                                                      child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                                        child: Text(firstPencil[index].cTA,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                                                      ),
                                                    ),

                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      )



                                  ),
                                ),

                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(padding: const EdgeInsets.only(right: 25),
                                    child: AnimatedOpacity(
                                      opacity: firstpencilvisible ?1 :0,
                                      duration:Duration(seconds: 1),
                                      child: firstpencilvisible==true?Text(firstPencil[index].brandname,):Container(height: 0,),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(height: 10,),
              Flexible(child: Padding(
                padding: const
                EdgeInsets.only(left: 10, right: 5),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      print('checkclickingindex${secondPencil[indexvalue2].brandname}');
                      Navigator.pushNamed(context, '/Whistlecta_webview');

                    });
                  },
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: itemextent,
                    controller: _controller1,
                    squeeze: squeeze,
                    diameterRatio: diameter,
                    perspective: perspective,
                    onSelectedItemChanged: (i){

                      setState(() {
                        indexvalue2=i;
                        get_impressions(secondPencil[i].creativeId);

                      });
                    },

                    renderChildrenOutsideViewport: false,
                    physics: NeverScrollableScrollPhysics(),
                    childDelegate: ListWheelChildLoopingListDelegate(
                      children: List<Widget>.generate(
                        secondPencil.length,
                            (index) => Container(
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(3)),
                                    color: secondpencilcolor[index]
                                ),
                                width: MediaQuery.of(context).size.width - 60,
                                child: Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Flexible(
                                              child: Wrap(
                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                alignment: WrapAlignment.spaceBetween,
                                                direction: Axis.horizontal,
                                                children: [
                                                  Text(secondPencil[index].headline,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){},
                                            child:  Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black.withOpacity(0.5),
                                                      blurRadius: 2.0,
                                                      spreadRadius: 2.0,
                                                      offset: Offset(-2.2, 3.3)
                                                  ),
                                                ],

                                              ),
                                              child: Center(
                                                child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                                  child: Text(secondPencil[index].cTA,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                                                ),
                                              ),

                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),

                              Align(alignment: Alignment.bottomRight,
                                child: Padding(padding: const EdgeInsets.only(right: 25),
                                  child: AnimatedOpacity(
                                    opacity: secondpencilvisible ?1 :0,
                                    duration:Duration(seconds: 1),
                                    child: secondpencilvisible==true?Text(secondPencil[index].brandname,):Container(height: 0,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(height: 10,),
              Flexible(child: Padding(
                padding: const
                EdgeInsets.only(left: 10, right: 5),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      print("get index value of pencil3${thirdpencil[indexvalue3].brandname}");
                      Navigator.pushNamed(context, '/Whistlecta_webview');

                    });
                  },
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: itemextent,
                    controller: _controller2,
                    squeeze: squeeze,
                    diameterRatio:diameter,
                    perspective: perspective,
                    onSelectedItemChanged: (i){
                      setState(() {
                        indexvalue3=i;
                        get_impressions(thirdpencil[i].creativeId);

                      });

                    },

                    renderChildrenOutsideViewport: false,
                    physics: NeverScrollableScrollPhysics(),
                    childDelegate: ListWheelChildLoopingListDelegate(
                      children: List<Widget>.generate(
                        thirdpencil.length,
                            (index) => Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){},
                                child:  Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      color: thirdpencilcolor[index]
                                  ),
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Flexible(
                                                child: Wrap(
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  alignment: WrapAlignment.spaceBetween,
                                                  direction: Axis.horizontal,
                                                  children: [
                                                    Text(thirdpencil[index].headline,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){},
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.5),
                                                        blurRadius: 2.0,
                                                        spreadRadius: 2.0,
                                                        offset: Offset(-2.2, 3.3)
                                                    ),
                                                  ],

                                                ),
                                                child: Center(
                                                  child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                                    child: Text(thirdpencil[index].cTA,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                                                  ),
                                                ),

                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Align(alignment: Alignment.bottomRight,
                                child: Padding(padding: const EdgeInsets.only(right: 25),
                                  child: AnimatedOpacity(
                                    opacity: thirdpencilvisible ?1 :0,
                                    duration:Duration(seconds: 1),
                                    child: thirdpencilvisible==true?Text(thirdpencil[index].brandname,):Container(height: 0,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        );
      }
    else if(pencilsize==4)
      {
        return Container(
          height: 360,
          child: Column(
            children: [
              Flexible(child: Padding(
                padding:
                EdgeInsets.only(left: 10, right: 5),
                child: GestureDetector(
                  onTap: (){
                    print("get index of click  ${firstPencil[indexvalue1].brandname}");

                    setState(() {
                      Navigator.pushNamed(context, '/Whistlecta_webview');

                    });

                  },
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: itemextent,
                    controller: _controller,
                    squeeze: squeeze,
                    diameterRatio: diameter,
                    perspective: perspective,
                    physics: NeverScrollableScrollPhysics(),
                    onSelectedItemChanged: (i) {

                     setState(() {
                       print('indexvalue${i}');
                       indexvalue1=i;
                       get_impressions(firstPencil[i].creativeId);
                       print("print the  cta${firstPencil[i].tracker}");

                     });



                    },
                    childDelegate: ListWheelChildLoopingListDelegate(



                      children: List<Widget>.generate(

                        firstPencil.length,

                            (index) => GestureDetector(

                          behavior: HitTestBehavior.translucent,

                          onTap: (){
                            setState(() {
                              print('jijkjndknfjbfk');
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      color: firstpencilcolor[index]
                                  ),
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: InkWell(
                                      onTap: (){
                                        print('clicked');
                                      },
                                      child: Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  child: Flexible(
                                                    child: Wrap(
                                                      crossAxisAlignment: WrapCrossAlignment.center,
                                                      alignment: WrapAlignment.spaceBetween,
                                                      direction: Axis.horizontal,
                                                      children: [
                                                        Text(firstPencil[index].headline,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  behavior: HitTestBehavior.translucent,

                                                  onTap: (){
                                                    setState(() {
                                                      print('clicked');
                                                      Navigator.pushNamed(context, '/Whistlecta_webview');
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black.withOpacity(0.5),
                                                            blurRadius: 2.0,
                                                            spreadRadius: 2.0,
                                                            offset: Offset(-2.2, 3.3)
                                                        ),
                                                      ],

                                                    ),
                                                    child: Center(
                                                      child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                                        child: Text(firstPencil[index].cTA,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                                                      ),
                                                    ),

                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      )



                                  ),
                                ),

                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(padding: const EdgeInsets.only(right: 25),
                                    child: AnimatedOpacity(
                                      opacity: firstpencilvisible ?1 :0,
                                      duration:Duration(seconds: 1),
                                      child: firstpencilvisible==true?Text(firstPencil[index].brandname,):Container(height: 0,),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(height: 10,),
              Flexible(child: Padding(
                padding: const
                EdgeInsets.only(left: 10, right: 5),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      print('checkclickingindex${secondPencil[indexvalue2].brandname}');
                      Navigator.pushNamed(context, '/Whistlecta_webview');

                    });
                  },
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: itemextent,
                    controller: _controller1,
                    squeeze: squeeze,
                    diameterRatio: diameter,
                    perspective: perspective,
                    onSelectedItemChanged: (i){

                     setState(() {
                       indexvalue2=i;
                       get_impressions(secondPencil[i].creativeId);

                     });
                    },

                    renderChildrenOutsideViewport: false,
                    physics: NeverScrollableScrollPhysics(),
                    childDelegate: ListWheelChildLoopingListDelegate(
                      children: List<Widget>.generate(
                        secondPencil.length,
                            (index) => Container(
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(3)),
                                    color: secondpencilcolor[index]
                                ),
                                width: MediaQuery.of(context).size.width - 60,
                                child: Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Flexible(
                                              child: Wrap(
                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                alignment: WrapAlignment.spaceBetween,
                                                direction: Axis.horizontal,
                                                children: [
                                                  Text(secondPencil[index].headline,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){},
                                            child:  Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black.withOpacity(0.5),
                                                      blurRadius: 2.0,
                                                      spreadRadius: 2.0,
                                                      offset: Offset(-2.2, 3.3)
                                                  ),
                                                ],

                                              ),
                                              child: Center(
                                                child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                                  child: Text(secondPencil[index].cTA,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                                                ),
                                              ),

                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),

                              Align(alignment: Alignment.bottomRight,
                                child: Padding(padding: const EdgeInsets.only(right: 25),
                                  child: AnimatedOpacity(
                                    opacity: secondpencilvisible ?1 :0,
                                    duration:Duration(seconds: 1),
                                    child: secondpencilvisible==true?Text(secondPencil[index].brandname,):Container(height: 0,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(height: 10,),
              Flexible(child: Padding(
                padding: const
                EdgeInsets.only(left: 10, right: 5),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      print("get index value of pencil3${thirdpencil[indexvalue3].brandname}");
                      Navigator.pushNamed(context, '/Whistlecta_webview');

                    });
                  },
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: itemextent,
                    controller: _controller2,
                    squeeze: squeeze,
                    diameterRatio:diameter,
                    perspective: perspective,
                    onSelectedItemChanged: (i){
                      setState(() {
                        indexvalue3=i;
                        get_impressions(thirdpencil[i].creativeId);


                      });

                    },

                    renderChildrenOutsideViewport: false,
                    physics: NeverScrollableScrollPhysics(),
                    childDelegate: ListWheelChildLoopingListDelegate(
                      children: List<Widget>.generate(
                        thirdpencil.length,
                            (index) => Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){},
                                child:  Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      color: thirdpencilcolor[index]
                                  ),
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Flexible(
                                                child: Wrap(
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  alignment: WrapAlignment.spaceBetween,
                                                  direction: Axis.horizontal,
                                                  children: [
                                                    Text(thirdpencil[index].headline,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){},
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.5),
                                                        blurRadius: 2.0,
                                                        spreadRadius: 2.0,
                                                        offset: Offset(-2.2, 3.3)
                                                    ),
                                                  ],

                                                ),
                                                child: Center(
                                                  child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                                    child: Text(thirdpencil[index].cTA,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                                                  ),
                                                ),

                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Align(alignment: Alignment.bottomRight,
                                child: Padding(padding: const EdgeInsets.only(right: 25),
                                  child: AnimatedOpacity(
                                    opacity: thirdpencilvisible ?1 :0,
                                    duration:Duration(seconds: 1),
                                    child: thirdpencilvisible==true?Text(thirdpencil[index].brandname,):Container(height: 0,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(height: 10,),
              Flexible(child: Padding(
                padding: const
                EdgeInsets.only(left: 10, right: 5),
                child: GestureDetector(
                  onTap: (){

                    setState(() {

                      print("get index value of pencil4${fourthpencil[indexvalue4].brandname}");
                      Navigator.pushNamed(context, '/Whistlecta_webview');
                    });
                  },
                  child:  ListWheelScrollView.useDelegate(
                    itemExtent: itemextent,
                    controller: _controller3,
                    squeeze: squeeze,
                    diameterRatio: diameter,
                    perspective: perspective,
                    onSelectedItemChanged: (i){
                      setState(() {
                        indexvalue4=i;
                        get_impressions(fourthpencil[i].creativeId);

                      });
                    },

                    renderChildrenOutsideViewport: false,
                    physics: NeverScrollableScrollPhysics(),
                    childDelegate: ListWheelChildLoopingListDelegate(
                      children: List<Widget>.generate(
                        fourthpencil.length,
                            (index) => Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){},
                                child:  Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      color: fourthpencilcolor[index]
                                  ),
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Flexible(
                                                child: Wrap(
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  alignment: WrapAlignment.spaceBetween,
                                                  direction: Axis.horizontal,
                                                  children: [
                                                    Text(fourthpencil[index].headline,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){},
                                              child:    Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.5),
                                                        blurRadius: 2.0,
                                                        spreadRadius: 2.0,
                                                        offset: Offset(-2.2, 3.3)
                                                    ),
                                                  ],

                                                ),
                                                child: Center(
                                                  child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                                    child: Text(fourthpencil[index].cTA,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                                                  ),
                                                ),

                                              ),
                                            ),

                                          ],
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Align(alignment: Alignment.bottomRight,
                                child: Padding(padding: const EdgeInsets.only(right: 25),
                                  child:  AnimatedOpacity(
                                    opacity: fourthpencilvisible ?1 :0,
                                    duration:Duration(seconds: 1),
                                    child: fourthpencilvisible==true?Text(fourthpencil[index].brandname,):Container(height: 0,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        );
      }
  }

  @override
  Widget build(BuildContext context) {

    whistleFeedModel =Provider.of<Whistle_Provider>(context, listen: true).whistleFeedModel;
    publisher_token_api=Provider.of<Whistle_Provider>(context,listen:true).publisher_token_api;


    return Scaffold(
        body: whistleFeedModel==null?Container(
          height: 0,
        ):
        Container(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Align(
                alignment: Alignment.topRight,
                child: Padding(padding: const EdgeInsets.only(right: 25,top: 10),
                  child: RichText(
                    text: TextSpan(
                      text: 'Whistle  ',
                      style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Feed | ',
                            style: TextStyle(
                                fontStyle: FontStyle.normal
                            )

                        ),
                        TextSpan(text: 'Sponsored',
                            style: TextStyle(
                                fontStyle: FontStyle.normal
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              pencils()
            ],
          ),
        ));
  }
}
