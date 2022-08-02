import 'adshowlistener.dart';

class MyAdShowListener implements AdShowListener
  {
  @override
  String onAdShowClick() {
   print("On Adds Click");
  }

  @override
  String onAdShowComplete() {

    print("On Adds complete");
  }

  @override
  String onAdShowFailure(String errorMsg) {
    print(errorMsg);
  }

  @override
  String onAdShowStart() {
    // TODO: implement onAdShowStart
    print("On Adds Start");
  }
    
  }