import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  XFile? file = await picker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  return null;
}

void saveImageToPrefs(Uint8List image) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String base64Image = base64Encode(image); // Преобразуем в строку Base64
  prefs.setString(
      'profile_image', base64Image); // Сохраняем в SharedPreferences
}

Future<Uint8List?> loadImageFromPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? base64Image = prefs.getString('profile_image');
  if (base64Image != null) {
    return base64Decode(base64Image); // Декодируем обратно в Uint8List
  }
  return null;
}
