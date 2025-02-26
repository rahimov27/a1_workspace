import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';

class EditPageTitleWidget extends StatelessWidget {
  const EditPageTitleWidget({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Изменить",
      style: TextStyle(
        fontSize: 24,
        fontFamily: "sf",
        color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
      ),
    );
  }
}
