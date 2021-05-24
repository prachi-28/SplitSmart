class GroupData{

  String docID = "random@gmail.com";
  static int num = 20;
  static List<bool> inputs = new List<bool>();
  static List<String> selEmail = new List<String>();
  bool selected = false;

  GroupData();

  void setNum(int n){
    num = n;
  }

  int returnNum() {
    return num;
  }

  void setEmail(List<String> tempEmail) {
    selEmail.clear();
    for (int i=0 ; i<num ; i++) {
      if (inputs[i] == true) {
        selEmail.add(tempEmail[i]);
      }
    }
  }

  List<String> returnEmail() {
    return selEmail;
  }

  void initInputs() {
    inputs.clear();
  }

  void setInputs(List<bool> tempInputs) {
    inputs = tempInputs;
  }

  List<bool> returnInputs() {
    return inputs;
  }
}