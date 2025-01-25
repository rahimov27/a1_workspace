import 'package:a1_workspace/features/login/presentation/widgets/app_button_w_idget.dart';
import 'package:a1_workspace/features/service/presentation/widgets/service_text_field.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Добавление услуги",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "sf",
            color: AppColors.mainWhite,
          ),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              SizedBox(height: 24),
              ServiceTextField(
                text: "Имя",
              ),
              SizedBox(height: 12),
              ServiceTextField(
                text: "Фамилия",
              ),
              SizedBox(height: 12),
              ServiceTextField(
                text: "Номер телефона",
              ),
              SizedBox(height: 12),
              CustomDropdownButton(),
              SizedBox(height: 40),
              AppButtonWidget(
                text: "Добавить",
                borderRadius: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? _selectedValue;
  final List<String> _options = ["Мастер", "Подмастерье", "Ученик"];

  void _showCustomDropdownMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height + 5,
        offset.dx + renderBox.size.width,
        0,
      ),
      items: _options.map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
      color: AppColors.mainGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ).then((String? newValue) {
      if (newValue != null) {
        setState(() {
          _selectedValue = newValue;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCustomDropdownMenu(context),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.mainGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedValue ?? "Мастер",
              style: const TextStyle(
                  fontFamily: "sf-medium",
                  fontSize: 14,
                  color: AppColors.mainWhite),
            ),
            SvgPicture.asset("assets/svg/down-icon.svg"),
          ],
        ),
      ),
    );
  }
}
