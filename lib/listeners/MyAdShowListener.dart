import 'adshowlistener.dart';

class MyAdShowListener implements AdShowListener
  {
  @override
  String onAdShowClick(String messege) {
   print("On Adds Click");
   return messege;
  }

  @override
  String onAdShowComplete(String messege) {

    print("On Adds complete");
    return messege;
  }

  @override
  String onAdShowFailure(String errorMsg) {
    print(errorMsg);
    return errorMsg;
  }

  @override
  String onAdShowStart(String messege) {
    // TODO: implement onAdShowStart
    print("On Adds Start");
    return messege;
  }
    
  }