import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoaderWidget extends StatelessWidget {
  const AppLoaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
          color: AppColors.mainRed, size: 40),
    );
  }
}
