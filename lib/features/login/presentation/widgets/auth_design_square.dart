import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AuthDesignSquare extends StatelessWidget {
  final double bottom;
  final double left;
  final double rotate;
  const AuthDesignSquare(
      {super.key,
      required this.bottom,
      required this.left,
      required this.rotate});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      child: Transform.rotate(
        angle: rotate,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              // ignore: deprecated_member_use
              color: AppColors.mainRed.withOpacity(0.1),
            ),
          ),
        ),
      ),
    );
  }
}
