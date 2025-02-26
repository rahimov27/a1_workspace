import 'package:a1_workspace/features/history/presentation/widgets/edit_page_text_field.dart';
import 'package:a1_workspace/features/home/data/models/home_records_model.dart';
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
  const EditPage(
      {super.key,
      required this.phone,
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.service,
      required this.price,
      required this.status,
      required this.date});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // controllers
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController serviceController;
  late TextEditingController priceController;
  late TextEditingController statusController;
  late TextEditingController dateController;
  late TextEditingController phoneController;
  late TextEditingController idController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    serviceController = TextEditingController(text: widget.service);
    priceController = TextEditingController(text: widget.price);
    statusController = TextEditingController(text: widget.status);
    dateController = TextEditingController(text: widget.date);
    phoneController = TextEditingController(text: widget.phone);
    idController = TextEditingController(text: widget.id);
  }

  // _selectedDate
  DateTime _selectedDate = DateTime.now();

  // formateDate
  String formatedDate(DateTime date) {
    return DateFormat("MM-dd-HH:mm").format(date);
  }

  Map<String, String> statusTranslation = {
    "Ожидание": "pending",
    "В работе": "in_progress",
    "Завершено": "completed",
    "Отменено": "cancelled",
    "Нет оплаты": "unpaid",
  };

  String _selectedStatus = "Ожидание"; // Это значение будет выбранным статусом

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 44,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: isDarkMode
              ? SvgPicture.asset("assets/svg/arrow-left.svg")
              : SvgPicture.asset(
                  "assets/svg/arrow-left.svg",
                  // ignore: deprecated_member_use
                  color: AppColors.mainGrey,
                ),
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Изменить запись",
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
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.mainGrey),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      formatedDate(_selectedDate),
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "sf-medium",
                          color: AppColors.mainWhite),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (_) => SizedBox(
                    height: 250,
                    child: CupertinoPicker(
                      scrollController:
                          FixedExtentScrollController(initialItem: 2),
                      backgroundColor: AppColors.mainWhite,
                      itemExtent: 30,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          _selectedStatus = [
                            "Ожидание",
                            "В работе",
                            "Завершено",
                            "Отменено",
                            "Нет оплаты"
                          ][value];
                        });
                      },
                      children: [
                        Text("Ожидание"),
                        Text("В работе"),
                        Text("Завершено"),
                        Text("Отменено"),
                        Text("Нет оплаты"),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.mainGrey),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      _selectedStatus,
                      style: TextStyle(
                          fontFamily: "sf-medium", color: AppColors.mainWhite),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14),
            AppButtonWidget(
              text: "Изменить",
              onPressed: () {
                editRecord(
                    widget.id,
                    firstNameController.text,
                    lastNameController.text,
                    serviceController.text,
                    priceController.text);
                context.read<HomeBloc>().add(GetRecordsEvent());
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      )),
    );
  }

  Future<HomeRecordsModel> editRecord(String id, final String firstName,
      final String lastName, String service, String price) async {
    try {
      // Преобразуем статус в английский перед отправкой
      String statusInEnglish = statusTranslation[_selectedStatus] ?? "pending";

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
          "status": statusInEnglish // Используем английский статус
        },
      );
      if (response.statusCode == 200) {
        print("Record editted successfully");
      } else {
        print("Error editing record ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
    throw Exception("Error");
  }

  void _showCupertinoDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: _selectedDate,
                use24hFormat: true,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                    print(_selectedDate.toIso8601String());
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
