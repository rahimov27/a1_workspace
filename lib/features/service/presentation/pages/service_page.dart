import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/home/presentation/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a1_workspace/features/service/presentation/widgets/service_text_field.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/features/service/presentation/bloc/client_bloc.dart';
import 'package:a1_workspace/features/service/presentation/bloc/client_state.dart';
import 'package:a1_workspace/features/service/presentation/bloc/client_event.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart'; // Для форматирования даты

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _selectedStatus = "В ожидании";

  DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd.MM.yyyy'); // Формат даты

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _serviceController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _onAddPressed() {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final phone = _phoneController.text;
    final service = _serviceController.text;
    final price = _priceController.text;
    final status = _selectedStatus;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        service.isEmpty ||
        price.isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, заполните все поля!')),
      );
    } else {
      context.read<ClientBloc>().add(
            CreateClientRecordEvent(
              firstName: firstName,
              lastName: lastName,
              phone: phone,
              service: service,
              price: price,
              status: status!,
              date: _selectedDate!, // Передаем дату
            ),
          );
    }
  }

  void _showDatePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode:
                      CupertinoDatePickerMode.dateAndTime, // Режим дата и время
                  initialDateTime: _selectedDate ?? DateTime.now(),
                  use24hFormat: true, // 24-часовой формат времени
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Готово"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 44,
        leading: Navigator.canPop(context)
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/svg/arrow-left.svg"),
              )
            : null,
        surfaceTintColor: Colors.transparent,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: BlocListener<ClientBloc, ClientState>(
            listener: (context, state) {
              if (state is ClientRecordError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              } else if (state is ClientRecordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Услуга добавлена успешно!')),
                );
                context.read<HomeBloc>().add(GetRecordsEvent());
                context.read<CalendarBloc>().add(GetRecordsCalendarEvent());
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  ServiceTextField(
                    text: "Имя",
                    controller: _firstNameController,
                  ),
                  const SizedBox(height: 12),
                  ServiceTextField(
                    text: "Фамилия",
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: 12),
                  ServiceTextField(
                    text: "Номер телефона",
                    controller: _phoneController,
                  ),
                  const SizedBox(height: 12),
                  ServiceTextField(
                    text: "Услуга",
                    controller: _serviceController,
                  ),
                  const SizedBox(height: 12),
                  ServiceTextField(
                    text: "Цена",
                    controller: _priceController,
                  ),
                  const SizedBox(height: 12),
                  // Выбор даты
                  GestureDetector(
                    onTap: _showDatePicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.mainGrey,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate == null
                                ? "Выберите дату"
                                : _dateFormat.format(_selectedDate!),
                            style: const TextStyle(
                                fontFamily: "sf-regualr",
                                fontSize: 14,
                                color: AppColors.mainWhite),
                          ),
                          const Icon(Icons.calendar_today,
                              color: AppColors.mainWhite),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Статус работы
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.mainGrey,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        menuWidth: 200,
                        value: _selectedStatus,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedStatus = newValue;
                          });
                        },
                        items: <String>["В ожидании", "В процессе", "Завершено"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        style: const TextStyle(
                          color: AppColors.mainWhite,
                          fontSize: 14,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: AppColors.mainGrey,
                        icon: SvgPicture.asset("assets/svg/down-icon.svg"),
                        isExpanded: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<ClientBloc, ClientState>(
                    builder: (context, state) {
                      if (state is ClientRecordLoading) {
                        return const AppLoaderWidget();
                      }
                      return SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onAddPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Добавить",
                            style: TextStyle(
                              fontFamily: "sf-medium",
                              fontSize: 18,
                              color: AppColors.mainWhite,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
