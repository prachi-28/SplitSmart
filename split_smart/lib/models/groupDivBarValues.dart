class GroupDivBarValuesClass {

  static double _owes = 0.0;
  static double _owed = 0.0;
  static double _percent = 0.0;

  void setOwes(double owes) {
    _owes = owes;
    print(owes);
  }

  void setOwed(double owed) {
    _owed = owed;
  }

  void onTransactionUpdate(int owe, int owed) {
      _owes = owe.toDouble() + _owes;
      _owed = owed.toDouble() + _owed;
      if (_owes == 0 && _owed == 0) {
        _percent = 0;
      }
      else {
        _percent = _owes / (_owes + _owed);
      }
  }

 double getPercent() {
    return _percent;
  }

  double getOwed() {
    return _owed;
  }

  double getOwes() {
    return _owes;
  }
}