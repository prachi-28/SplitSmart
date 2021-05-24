import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/groups/GroupData.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
User user = FirebaseAuth.instance.currentUser;
GroupData _groupData = new GroupData();

class GroupDivBarValuesClass {

  String docID = user.email; //currentUser's document ID
  String gName = _groupData.returnGroupName();

  static double _owes = 0.0;
  static double _owed = 0.0;
  static double _percent = 0.0;

  void setOwesOwed() {
    _owes = 0;
    _owed = 0;
    FirebaseFirestore.instance
        .collection('users')
        .doc(docID)
        .collection('groups')
        .get()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            _owes = _owes + doc['totalOwes'];
            _owed = _owed + doc['totalOwed'];
            //print(doc['totalOwed']);
            //print(_owed);
            setOwes(_owes);
            setOwed(_owed);
            setPercent(_owes, _owed);
          });
    });
  }

  void setPercent(double _owes, double _owed) {
    if (_owes == 0 && _owed == 0) {
      _percent = 0;
    }
    else {
      _percent = _owed / (_owes + _owed);
    }
    print("HELLO PERCENT");
    //print(_owed);
    print(_percent);
  }

  void setOwes(double owes) {
    _owes = owes;
    //print(owes);
  }

  void setOwed(double owed) {
    _owed = owed;
    //print("OWS");
    //print(_owed);
  }

  void onTransactionUpdate(double owe, double owed) {
      _owes = owe + _owes;
      _owed = owed + _owed;
      if (_owes == 0 && _owed == 0) {
        _percent = 0;
      }
      else {
        _percent = _owed / (_owes + _owed);
      }
  }

 double getPercent() {
    return _percent;
  }

  double getOwed() {
    //print(_owed);
    return _owed;
  }

  double getOwes() {
    return _owes;
  }
}