import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AuthDesignCircle extends StatelessWidget {
  final double top;
  final double left;
  const AuthDesignCircle({super.key, required this.left, required this.top});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: CircleAvatar(
        radius: 212.5,
        // ignore: deprecated_member_use
        backgroundColor: AppColors.mainRed.withOpacity(0.05),
      ),
    );
  }
}
