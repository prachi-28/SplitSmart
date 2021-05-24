import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
User user = FirebaseAuth.instance.currentUser;

class GroupData{

  String docID = user.email;

  static String groupName = '';
  static int num = 20;
  static List<bool> inputs = new List<bool>();
  static List<String> selEmail = new List<String>();
  bool selected = false;

  GroupData();

  void setGroupName(String name) {
    groupName = name;
  }

  String returnGroupName() {
    return groupName;
  }

  Future<void> memberEmails(String gName) async{
    List<String> tempEmail = new List<String>();
    print(tempEmail);
    tempEmail.clear();
    FirebaseFirestore.instance
        .collection('users')
        .doc(docID)
        .collection('groups')
        .doc(gName)
        .collection('members')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        tempEmail.add(doc['memail']);
        print(tempEmail);
        selEmail = tempEmail;
      });
    });
    //selEmail = tempEmail;
    print(selEmail);
    print("DONE!");
  }

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