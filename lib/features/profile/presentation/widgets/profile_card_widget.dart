import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget {
  final String name;
  const ProfileCardWidget({
    super.key,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.mainGrey,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          const Positioned(
            left: 85,
            top: -282,
            child: CircleAvatar(
              radius: 282,
              backgroundColor: Color(0xff2E2F34),
            ),
          ),
          const Positioned(
            left: 134,
            top: -232,
            child: CircleAvatar(
              radius: 232,
              backgroundColor: Color(0xff38393E),
            ),
          ),
          const Positioned(
            left: 184,
            top: -182,
            child: CircleAvatar(
              radius: 183,
              backgroundColor: Color(0xff424348),
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
                    child: const CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                          "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg"),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                 Text(
                  name,
                  style: const TextStyle(
                      fontSize: 22,
                      fontFamily: "sf-medium",
                      color: AppColors.mainWhite),
                ),
                const Text(
                  "+996-500-10-20-30",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "sf-regular",
                      color: AppColors.greyHomeCard),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
