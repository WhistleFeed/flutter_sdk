import 'adshow_listener.dart';

class MyAdShowListener implements AdShowListener {
  @override
  String onAdShowClick(String messege) {
    print("On Adds Click");
    return messege; // click on adds
  }

  @override
  String onAdShowComplete(String messege) {
    print("On Adds complete");
    return messege; // adds show complete
  }

  @override
  String onAdShowFailure(String errorMsg) {
    print(errorMsg);
    return errorMsg; // adds have errors
  }

  @override
  String onAdShowStart(String messege) {
    // TODO: implement onAdShowStart
    print("On Adds Start");
    return messege; //adds start
  }
}
