import 'dart:typed_data';

import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:a1_workspace/shared/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileCardWidget extends StatefulWidget {
  final String name;
  const ProfileCardWidget({super.key, required this.name});

  @override
  State<ProfileCardWidget> createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    loadImageFromPrefs().then((loadedImage) {
      if (loadedImage != null) {
        setState(() {
          _image = loadedImage;
        });
      }
    });
  }

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
      saveImageToPrefs(img); // Сохраняем изображение в SharedPreferences
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDarkMode ? AppColors.mainGrey : AppColors.mainWhite,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            left: 85,
            top: -282,
            child: CircleAvatar(
              radius: 282,
              backgroundColor: isDarkMode
                  ? Color(0xff2E2F34)
                  // ignore: deprecated_member_use
                  : AppColors.mainRed.withOpacity(0.50),
            ),
          ),
          Positioned(
            left: 134,
            top: -232,
            child: CircleAvatar(
              radius: 232,
              backgroundColor: isDarkMode
                  ? Color(0xff38393E)
                  // ignore: deprecated_member_use
                  : AppColors.mainRed.withOpacity(0.60),
            ),
          ),
          Positioned(
            left: 184,
            top: -182,
            child: CircleAvatar(
              radius: 183,
              backgroundColor:
                  isDarkMode ? Color(0xff424348) : AppColors.mainRed,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.mainWhite,
                        width: 4.0,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: _image != null
                          ? CircleAvatar(
                              backgroundColor: AppColors.greyAuth,
                              radius: 45,
                              backgroundImage: MemoryImage(_image!))
                          : const CircleAvatar(
                              backgroundColor: AppColors.greyAuth,
                              radius: 45,
                              backgroundImage: AssetImage(
                                "assets/svg/profile-default.png",
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.name,
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: "sf-medium",
                      color: isDarkMode
                          ? AppColors.mainWhite
                          : AppColors.mainGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
