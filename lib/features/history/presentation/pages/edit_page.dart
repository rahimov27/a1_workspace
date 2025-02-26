import 'package:a1_workspace/features/history/presentation/widgets/edit_page_text_field.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/login/presentation/widgets/app_button_widget.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/core/utils/swagger_adress.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:a1_workspace/shared/utils/dio_settings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final String id;
  final String firstName;
  final String lastName;
  final String service;
  final String price;
  final String status;
  final String date;
  final String phone;
  const EditPage({
    super.key,
    required this.phone,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.service,
    required this.price,
    required this.status,
    required this.date,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController serviceController;
  late TextEditingController priceController;
  late TextEditingController dateController;
  late TextEditingController phoneController;
  late TextEditingController idController;

  DateTime _selectedDate = DateTime.now();
  late String _selectedStatus;

  final List<String> statusList = [
    "Ожидание",
    "В работе",
    "Завершено",
    "Отменено",
    "Нет оплаты"
  ];

  final Map<String, String> reverseStatusTranslation = {
    "pending": "Ожидание",
    "in_progress": "В работе",
    "completed": "Завершено",
    "cancelled": "Отменено",
    "unpaid": "Нет оплаты",
  };

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    serviceController = TextEditingController(text: widget.service);
    priceController = TextEditingController(text: widget.price);
    dateController = TextEditingController(text: widget.date);
    phoneController = TextEditingController(text: widget.phone);
    idController = TextEditingController(text: widget.id);

    _selectedStatus = reverseStatusTranslation[widget.status] ?? widget.status;
  }

  String formatedDate(DateTime date) {
    return DateFormat("MM-dd-HH:mm").format(date);
  }

  void _showCupertinoDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        color: Colors.white,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.dateAndTime,
          initialDateTime: _selectedDate,
          use24hFormat: true,
          onDateTimeChanged: (DateTime newDate) {
            setState(() {
              _selectedDate = newDate;
            });
          },
        ),
      ),
    );
  }

  Future<void> editRecord(String id, String firstName, String lastName,
      String service, String price) async {
    try {
      String statusInEnglish =
          reverseStatusTranslation[_selectedStatus] ?? "pending";

      final response = await dio.put(
        "${SwaggerAdress.adress}/$id/",
        options: Options(
          headers: {"Authorization": SwaggerAdress.apiKey},
        ),
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "service": service,
          "price": double.tryParse(price),
          "date": _selectedDate.toIso8601String(),
          "status": reverseStatusTranslation.entries
              .firstWhere((entry) => entry.value == _selectedStatus,
                  orElse: () => const MapEntry("pending", "Ожидание"))
              .key,
        },
      );

      if (response.statusCode == 200) {
        print("Record edited successfully");
      } else {
        print("Error editing record: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 44,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: isDarkMode
              ? SvgPicture.asset("assets/svg/arrow-left.svg")
              : SvgPicture.asset(
                  "assets/svg/arrow-left.svg",
                  color: AppColors.mainGrey,
                ),
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Изменить",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "sf",
            color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              const SizedBox(height: 24),
              EditPageTextField(
                  controller: firstNameController, isDarkMode: isDarkMode),
              EditPageTextField(
                  controller: lastNameController, isDarkMode: isDarkMode),
              EditPageTextField(
                  controller: serviceController, isDarkMode: isDarkMode),
              EditPageTextField(
                  controller: priceController, isDarkMode: isDarkMode),
              GestureDetector(
                onTap: _showCupertinoDatePicker,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.mainGrey,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    formatedDate(_selectedDate),
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "sf-regular",
                        color: AppColors.mainWhite),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (_) => SizedBox(
                      height: 250,
                      child: CupertinoPicker(
                        backgroundColor: AppColors.mainWhite,
                        itemExtent: 30,
                        scrollController: FixedExtentScrollController(
                          initialItem: statusList.indexOf(_selectedStatus),
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedStatus = statusList[index];
                          });
                        },
                        children:
                            statusList.map((status) => Text(status)).toList(),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.mainGrey,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    _selectedStatus,
                    style: const TextStyle(
                        fontFamily: "sf-regular", color: AppColors.mainWhite),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              AppButtonWidget(
                text: "Изменить",
                onPressed: () {
                  editRecord(
                    widget.id,
                    firstNameController.text,
                    lastNameController.text,
                    serviceController.text,
                    priceController.text,
                  );
                  context.read<HomeBloc>().add(GetRecordsEvent());
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
