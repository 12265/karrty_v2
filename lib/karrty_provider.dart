import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:karttyas/moddles/contracts_moddle.dart';
import 'package:karttyas/moddles/work_trackers_moddle.dart';
import 'http_files/karrty_url.dart';
import 'moddles/actif_marches_moddle.dart';
import 'moddles/quotations_moddle.dart';
class KarrtyProvider extends ChangeNotifier
{
  Map<String,String> queryParamets = {};
  final localStorage = FlutterSecureStorage();
  List<MarcheModdle> marcheModdle = [];
  List<ContractsModdle> contractsModdle = [];
  List<QuotationsModdle> qutationModdle = [];
  bool textHasError = false;
  int errorIndex = 0;
  bool rememberMeBool = true;
  Future<bool> firstLogin() async {
    Future<bool> value = localStorage.containsKey(key: "refresh_token");
    return value;
  }
  void textHasAnError(int i )
  {
    errorIndex = i;
    textHasError = true;
    notifyListeners();
  }
  void hasValue(String type,final value)
  {
    if(type == "marcheModdle") {
      marcheModdle = value;
    }
    else if(type == "ContractsModdle")
      {
        contractsModdle = value;
      }
  }
  int marcheIndex = 0;
  void changeMarchIndex(int index)
  {
    marcheIndex = index;
  }
  void rememberMe()
  {
    rememberMeBool == false ? rememberMeBool = true: rememberMeBool= false;
    notifyListeners();
  }
  void karrtyLogin(String username,String password)async
  {
    queryParamets["username"] = username;
    queryParamets["password"] = password;
    final responde = await post(Uri.https(baseUrl,"/login",queryParamets));
    final body = jsonDecode(responde.body);
    localStorage.write(key: "refresh_token", value: body["refresh_token"]);
    localStorage.write(key: "access_token", value: body["access_token"]);
    localStorage.write(key: "username", value: username);
    localStorage.write(key: "remember me", value: rememberMeBool.toString());
    notifyListeners();
  }
  void disconnect()
  {
    localStorage.deleteAll();
    notifyListeners();
}
  Map<String,String> textInputSaveValues = {"username": "","password": "","marché": "","sous-traitant": ""};
  void textInputSaveValue(String type,String val)
  {
    textInputSaveValues[type] = val;
  }
}