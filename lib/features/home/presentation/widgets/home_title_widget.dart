import 'package:a1_workspace/features/profile/data/provider/name_provider.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeTitleWidget extends StatelessWidget {
  const HomeTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final providerName = Provider.of<NameProvider>(context);
    String todayDate = DateFormat('E, dd MMMM', 'ru_RU').format(DateTime.now());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 250,
              child: Text(
                "Привет, ${providerName.name}!",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 24,
                  fontFamily: "sf",
                  color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              todayDate,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: "sf-medium",
                color: AppColors.textGreyColor,
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
