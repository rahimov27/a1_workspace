import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:a1_workspace/features/service/presentation/widgets/service_text_field.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/features/service/presentation/bloc/client_bloc.dart';
import 'package:a1_workspace/features/service/presentation/bloc/client_state.dart';
import 'package:a1_workspace/features/service/presentation/bloc/client_event.dart';
import 'package:flutter_svg/svg.dart';

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
  final TextEditingController _priceController =
      TextEditingController(); // Новый контроллер для цены
  String? _selectedService;
  String? _selectedStatus = "В ожидании"; // Статус по умолчанию

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _serviceController.dispose();
    _priceController.dispose(); // Уничтожаем контроллер для цены
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
        price.isEmpty) {
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
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              }
            },
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
                  controller: _priceController, // Добавляем поле для цены
                ),
                const SizedBox(height: 12),
                // Статус работы
                DropdownButton<String>(
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
                  dropdownColor: AppColors.mainGrey,
                  hint: const Text(
                    "Статус",
                    style: TextStyle(
                      fontFamily: "sf-medium",
                      fontSize: 14,
                      color: AppColors.mainWhite,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<ClientBloc, ClientState>(
                  builder: (context, state) {
                    if (state is ClientRecordLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: _onAddPressed,
                      child: const Text("Добавить"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
