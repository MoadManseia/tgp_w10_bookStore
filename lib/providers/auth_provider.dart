import 'dart:convert';
import 'package:books_store/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  uninitialized,
  unauthenticated,
  authenticated,
  authenticating,
}

class AuthProvider extends BaseProvider {
  AuthStatus status = AuthStatus.uninitialized;
  String? token;

  Future<void> initAuthProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? tempToken = prefs.getString("token");

    if (tempToken != null) {
      status = AuthStatus.authenticated;
      token = tempToken;
      setBusy(false);
    } else {
      status = AuthStatus.unauthenticated;
      token = null;
      setBusy(false);
    }
  }

  Future<List> register(Map body) async {
    setBusy(true);
    final response = await api.post("/api/customer/sign-up", body);
    if (response.statusCode == 201) {
      setFailed(false);
      setBusy(false);
      return [true, json.decode(response.body)['message']];
    } else {
      setFailed(true);
      setBusy(false);
      return [false, json.decode(response.body)['message']];
    }
  }

  Future<List> registerAuthor(Map body) async {
    setBusy(true);
    final response = await api.post("/api/author/sign-up", body);
    if (response.statusCode == 201) {
      setFailed(false);
      setBusy(false);
      return [true, json.decode(response.body)['message']];
    } else {
      setFailed(true);
      setBusy(false);
      return [false, json.decode(response.body)['message']];
    }
  }

  Future<List> login(Map body) async {
    setBusy(true);
    final response = await api.post("/api/login", body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString("token", json.decode(response.body)['access_token']);

      setFailed(false);
      setBusy(false);
      return [true, "User Loged Successfully"];
    } else {
      setFailed(true);
      setBusy(false);
      return [false, json.decode(response.body)['message']];
    }
  }

  void getMe() {}

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    status = AuthStatus.unauthenticated;
    setBusy(false);
    return true;
  }
}
