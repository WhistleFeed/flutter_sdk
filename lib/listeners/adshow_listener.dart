class AdShowListener
{
  String onAdShowFailure(String errorMsg){
    return errorMsg; // adds failure
  }
  String onAdShowStart(String messege){
    return messege; // adds start
  }
  String onAdShowClick(String messege){
    return messege; //adds click
  }
  String onAdShowComplete(String messege){
    return messege; // adds complete
  }

}