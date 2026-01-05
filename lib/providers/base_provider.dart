import 'package:books_store/services/api.dart';
import 'package:flutter/cupertino.dart';

class BaseProvider with ChangeNotifier {
  bool busy = false;
  Api api = Api();

  void setBusy(bool status) {
    busy = status;
    notifyListeners();
  }

  bool failed = false;

  void setFailed(bool status) {
    failed = status;
    notifyListeners();
  }

  String? errorMessage;
  void setErrorMessage(String? msg) {
    errorMessage = msg;
    notifyListeners();
  }
}
