import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/service/presentation/widgets/service_adaptive_text_widget.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:a1_workspace/shared/utils/widgets/app_loader_widget.dart';
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
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ThreeMoikaPage extends StatefulWidget {
  const ThreeMoikaPage({super.key});

  @override
  State<ThreeMoikaPage> createState() => _ThreeMoikaPageState();
}

class _ThreeMoikaPageState extends State<ThreeMoikaPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _selectedStatus = "В ожидании";

  DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd.MM.yyyy'); // Формат даты

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _onAddPressed() {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final phone = _phoneController.text;
    final service = selectedService;
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
              service: selectedService,
              price: price,
              status: status!,
              date: _selectedDate!, // Передаем дату
            ),
          );
    }
  }

  void _showCupertinoDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        color: AppColors.mainGrey,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate ?? DateTime.now(),
                use24hFormat: true,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 44,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Добавление услуги",
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
          child: BlocListener<ClientBloc, ClientState>(
            listener: (context, state) {
              if (state is ClientRecordError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              } else if (state is ClientRecordSuccess) {
                showCustomOverlay(context);
                context.read<HomeBloc>().add(GetRecordsEvent());
                context.read<CalendarBloc>().add(GetRecordsCalendarEvent());
                _firstNameController.clear();
                _lastNameController.clear();
                _phoneController.clear();
                _priceController.clear();
                setState(() {
                  _selectedDate = null;
                  _selectedStatus = "В ожидании";
                });
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
                    textInputType: const TextInputType.numberWithOptions(),
                    text: "Номер телефона",
                    controller: _phoneController,
                  ),
                  const SizedBox(height: 12),
                  ServiceTextField(
                    text: "Цена",
                    textInputType: TextInputType.number,
                    controller: _priceController,
                  ),
                  const SizedBox(height: 12),

                  // Выбор даты
                  GestureDetector(
                    onTap: _showCupertinoDatePicker,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isDarkMode
                            ? AppColors.mainGrey
                            : AppColors.mainWhite,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate == null
                                ? "Выберите дату"
                                : _dateFormat.format(_selectedDate!),
                            style: TextStyle(
                                fontFamily: "sf-regualr",
                                fontSize: 14,
                                color: isDarkMode
                                    ? AppColors.mainWhite
                                    : AppColors.mainGrey),
                          ),
                          isDarkMode
                              ? SvgPicture.asset("assets/svg/calendar.svg")
                              : SvgPicture.asset(
                                  "assets/svg/calendar.svg",
                                  // ignore: deprecated_member_use
                                  color: AppColors.mainGrey,
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Статус работы
                  // tonirokva
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          isDarkMode ? AppColors.mainGrey : AppColors.mainWhite,
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
                        style: TextStyle(
                          color: isDarkMode
                              ? AppColors.mainWhite
                              : AppColors.mainGrey,
                          fontSize: 14,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: isDarkMode
                            ? AppColors.mainGrey
                            : AppColors.mainWhite,
                        icon: isDarkMode
                            ? SvgPicture.asset("assets/svg/down-icon.svg")
                            : SvgPicture.asset(
                                "assets/svg/down-icon.svg",
                                // ignore: deprecated_member_use
                                color: AppColors.mainGrey,
                              ),
                        isExpanded: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.mainWhite),
                          child: CupertinoPicker(
                            backgroundColor: AppColors.mainGrey,
                            itemExtent: 32,
                            onSelectedItemChanged: (index) {
                              if (index == 0) {
                                selectedService = 'Тщательная мойка интерьера';
                              } else if (index == 1) {
                                selectedService = 'Мойка двигателя';
                              } else if (index == 2) {
                                selectedService = 'Мойка двигателя и подвески';
                              } else if (index == 3) {
                                selectedService = 'Генеральная уборка салона';
                              }
                              setState(() {
                                selectedService = services[index];
                              });
                            },
                            children: [
                              ServiceAdaptiveTextWidget(
                                  text: "Тщательная мойка интерьера"),
                              ServiceAdaptiveTextWidget(
                                  text: "Мойка двигателя"),
                              ServiceAdaptiveTextWidget(
                                  text: "Мойка двигателя и подвески"),
                              ServiceAdaptiveTextWidget(
                                  text: "Генеральная уборка салона"),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isDarkMode
                              ? AppColors.mainGrey
                              : AppColors.mainWhite),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Text(
                            selectedService,
                            style: TextStyle(
                                fontFamily: "sf-regualr",
                                fontSize: 14,
                                color: isDarkMode
                                    ? AppColors.mainWhite
                                    : AppColors.bottomNavbarGrey),
                          ),
                        ),
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

// SelectedService tonirovka
String selectedService = 'Услуги';
List<String> services = [
  "3х фазная мойка + тщательная мойка интерьера",
  "3х фазная мойка + мойка двигателя",
  "3х фазная мойка + мойка двигателя и подвески со снятием колес и арок",
  "Генеральная уборка салона сухая химчистка мойка двигателя"
];

void showCustomOverlay(BuildContext context) {
  OverlayState overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => _AnimatedOverlay(
      onDismiss: () => overlayEntry.remove(),
    ),
  );

  overlayState.insert(overlayEntry);
}

class _AnimatedOverlay extends StatefulWidget {
  final VoidCallback onDismiss;

  const _AnimatedOverlay({required this.onDismiss});

  @override
  _AnimatedOverlayState createState() => _AnimatedOverlayState();
}

class _AnimatedOverlayState extends State<_AnimatedOverlay>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Вибрация при появлении
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        HapticFeedback.mediumImpact(); // Вибрация
        setState(() => _opacity = 1.0);
      }
    });

    // Плавное исчезновение через 2 секунды
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _opacity = 0.0);
    });

    // Удаление через 2.5 секунды
    Future.delayed(const Duration(milliseconds: 2500), widget.onDismiss);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.scaffoldColor
          : AppColors.mainWhite, // Затемнение фона
      body: SafeArea(
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _opacity,
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              // ignore: deprecated_member_use
              backgroundColor: const Color(0xff59E66F).withOpacity(0.25),
            ),
            CircleAvatar(
              radius: 50,
              // ignore: deprecated_member_use
              backgroundColor: const Color(0xff59E66F).withOpacity(0.40),
            ),
            const CircleAvatar(radius: 30, backgroundColor: Color(0xff59E66F)),
            Positioned(
              top: 58,
              left: 58,
              child: SvgPicture.asset("assets/svg/done.svg"),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Column(
          children: [
            Text(
              "Успешно",
              style: TextStyle(
                fontFamily: "sf-medium",
                color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 4),
            Text(
              textAlign: TextAlign.center,
              "Данные успешно отправлены!",
              style: TextStyle(
                height: 1,
                fontFamily: "sf-medium",
                color: Color(0xff919191),
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
