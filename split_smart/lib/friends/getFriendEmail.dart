class getFriendEmail {

  getFriendEmail();
  static String e;

  void setEmail(String femail) {
    if(femail==null)
      {
        print("null femail");
      }
    e=femail;
  }

  String getEmail() {
    return e;
  }

}