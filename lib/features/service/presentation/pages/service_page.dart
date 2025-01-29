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
  String? _selectedService;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onAddPressed() {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final phone = _phoneController.text;
    final service = _selectedService;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        service == null) {
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
                CustomDropdownButton(
                  onSelected: (service) {
                    setState(() {
                      _selectedService = service;
                    });
                  },
                  selectedValue: _selectedService,
                ),
                const SizedBox(height: 40),
                BlocBuilder<ClientBloc, ClientState>(
                  builder: (context, state) {
                    if (state is ClientRecordLoading) {
                      return Center(child: CircularProgressIndicator());
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

class CustomDropdownButton extends StatefulWidget {
  final Function(String) onSelected;
  final String? selectedValue;

  const CustomDropdownButton({
    super.key,
    required this.onSelected,
    this.selectedValue,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  final List<String> _options = ["Тонировка", "Полировка", "Химчистка"];

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
        widget.onSelected(newValue);
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
              widget.selectedValue ?? "Услуга",
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
