import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameProvider extends ChangeNotifier {
  String _name = 'Admin';
  String get name => _name;

  TextEditingController nameController = TextEditingController();

  NameProvider() {
    getName();
  }

  void changeName(String name) {
    _name = name;
    notifyListeners();
  }

  Future<void> saveName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", name);
    _name = name;
    notifyListeners();
  }

  Future<void> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final newName = prefs.getString("userName");
    _name = newName ?? "Admin";
    notifyListeners();
  }
}
